---
layout: post
title: "Building a Canasta App with Our House Rules, Day 1: Spec First"
date: 2026-11-18
author: "Eduardo Diaz Sancha"
timeToRead: "5 minutes read"
description: "My family has played Canasta with its own house rules for decades, so I started building an app that plays by them, on iPhone, Android and the web, following the way Shopify rebuilt its app."
categories: development
---

My family has played Canasta for as long as I can remember. With friends, at four or six players, always with our own house rules. Recently I downloaded a Canasta app and got annoyed quickly: it played by rules we don't follow at home.

So I decided to build our own. Three requirements: it runs on iPhone and Android, it plays by the official rules *and* by our family rules, and friends in different houses can play together, with voice and video later.

I built it with Claude Code, running several agents in parallel. This is the first of two posts on how the first two days went.

## Writing the rules down

Before any code, I wanted a requirements document. Claude drafted a PRD with goals, table formats (four players in two teams, six players in three teams), and the official rules from [Pagat](https://www.pagat.com/rummy/canasta.html){:rel="external nofollow" target="_blank"}.

The most useful part was a table of 26 rules that households tend to disagree on, with the official version in one column and an empty "Ours" column. Filling it in was the first time I had written our rules down. Some highlights:

- The discard pile is always frozen: you can only take it with a natural pair of the top card.
- A canasta of only wild cards is allowed, and it is worth 2,000, 2,500 for four jokers and three twos, or 3,000 for seven twos.
- On the cut, four face-down cards go into the pile under the first card.
- Black threes need four of a kind to be melded, and only when going out.

Those 26 answers became the most important file in the project.

## Copying Shopify on purpose

For the architecture I took two Shopify Engineering articles that came out the same month: [how they rebuilt their app in native Swift and Kotlin](https://shopify.engineering/shopify-app-rebuild){:rel="external nofollow" target="_blank"} and [Reflex](https://shopify.engineering/reflex){:rel="external nofollow" target="_blank"}, the architecture behind it.

The idea that stuck with me: Shopify shares no production code between iOS and Android. Each platform writes its own logic, in its own language, and **the tests are the shared artifact**. Every screen has the same shape on both platforms (state out, actions in, one update function), and every platform has a command-line tool so an agent can drive the app without a simulator.

I decided to follow it as closely as I could:

- Native apps in **Swift** (SwiftUI) and **Kotlin** (Compose).
- The rules written **separately** in each language, plus a third copy in **Rust** for the game server. Rust is a new language for me, and I wanted to learn it.
- One `spec/` folder that every platform must pass: the rule sets as JSON (so a house rule is data, never an `if`), and hundreds of game scenarios, also JSON, that state a starting position, a list of moves and the expected result.

Three copies of the rules sounds like a lot of duplication. In practice, the shared scenarios keep them honest. If Swift and Kotlin disagree about whether you can take the pile, a scenario fails, and the spec decides who is right.

## Checkpoints, not sprints

The plan broke phase 1 into checkpoints: cards and the deal, melds and the pile, going out and scoring, a command-line interface, computer players, and the table screens. Each checkpoint ran as a small workflow of agents:

1. One agent writes the spec: scenarios and expected values.
2. Three agents, Swift, Kotlin and Rust, build it in parallel, none of them allowed to touch the spec.
3. If an implementer thinks the spec is wrong, an arbiter agent decides.
4. Two reviewers look for problems: one checks the rules, the other checks that the three platforms mirror each other.
5. One pull request, which I review and merge.

The first real test was the shuffle. All three platforms use the same random number generator (PCG32, checked against its published reference values) and the same Fisher–Yates shuffle, so the same seed deals the same hands on iPhone, Android and the server. That property, which the tests call parity, became the backbone of everything else.

## Running things in parallel

While the checkpoints ran, other agents worked on things that didn't touch the same files: phone mockups of the table designed for the older players in the family (large indices, a four-colour deck, colour never the only cue), research on card artwork whose licence lets us ship it, and a written strategy for the computer players. I merged those in between.

By the end of the evening we had the deal, melds, wild cards, the discard pile and scoring, all passing the same scenarios on three platforms. We also had a command-line tool for each platform that speaks the same JSON. One set of behaviour tests, written once in TypeScript, drives all three tools. Those tests found that Swift accepted JSON with a trailing comma and Kotlin accepted unquoted words, two disagreements no human would have spotted.

## What went wrong

Plenty.

**The disk filled up.** One agent, testing a database schema, started Docker and pulled Postgres images. That filled the Mac, and every agent stopped at once, mid-task. Cleaning up meant deleting old simulators (14 GB), Docker's images and build folders, and from then on every agent checks free space before a heavy build.

**I hit my usage limit**, twice. Everything paused until it reset, and the work resumed from where it stopped, because each workflow keeps a journal of finished steps.

**I changed my mind about the database.** The plan used Supabase for sign-in and Postgres. Halfway through, I asked why. The Rust server was already the single gatekeeper for every move, so Supabase's row-level security would have been a second set of rules to keep in sync with the server. I switched to plain Postgres, with the server checking Sign in with Apple and Google itself. The Supabase PR, finished and reviewed, got closed. That was the right call, and a cheap one to make on day 1.

## What I learned on day 1

The writing came before the code, and it paid off. The 26-row family rules table and the shared scenarios did more for quality than any review.

My job changed. I spent the day making decisions (native or cross-platform, Supabase or Postgres, which rules are ours), reading pull requests and merging. Agents did the typing. The bottlenecks were my attention, the disk and the usage limit, not the code.

Tomorrow: computer players, a web version, and playing online.
