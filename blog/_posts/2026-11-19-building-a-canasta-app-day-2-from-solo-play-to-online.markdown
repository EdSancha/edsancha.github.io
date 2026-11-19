---
layout: post
title: "Building a Canasta App with Our House Rules, Day 2: From Solo Play to Playing Online"
date: 2026-11-19
author: "Eduardo Diaz Sancha"
timeToRead: "5 minutes read"
description: "On day two the Canasta app got computer players, a web version running the same Rust rules engine, online tables with a lobby, and its first real game, which I lost."
categories: development
---

[Yesterday]({% post_url blog/2026-11-18-building-a-canasta-app-day-1-spec-first %}) ended with the rules of Canasta, ours and the official ones, passing the same scenarios in Swift, Kotlin and Rust. Today the goal was to make it playable: against the computer first, then with other people.

## Computer players that agree with each other

Day 1 produced a written strategy for the computer players: what they can see (only their own hand and the public table), how they decide what to discard, when they freeze the pile, when they go out. Overnight and into the morning, each platform implemented it, Easy and Normal.

The interesting test is parity again. Fifty seeded games per rule set must produce the same game log, hash for hash, on all three platforms; a longer run of a thousand games per rule set matched too. If the Swift bot discards a different card than the Kotlin bot on move 437 of game 812, the test says so. Normal beats Easy in about 70% of games, which felt right.

## A web version, without a fourth copy of the rules

Early on day two I added a web client to the roadmap. Writing the rules a fourth time, in TypeScript, didn't appeal to me. Instead, the Rust rules engine compiles to WebAssembly, and a small React app sends it the same commands as the command-line tools.

The nice part is the testing. The same behaviour tests that drive the Swift, Kotlin and Rust tools now drive the WebAssembly build directly. One test that only makes sense for an operating system process is skipped, and the WebAssembly version gets its own check instead: the module may not import any network functions. On top of that, Playwright plays full hands in a real browser, including a scan for accessibility problems, which caught two real ones.

## Playing online

The online pieces landed one after another, each in its own pull request:

- The game server in Rust (Axum): one task per table, and each player receives only their own view of the game. Other players' hands, the order of the stock and the shuffle seed never leave the server.
- Sign in with Apple and Google, checked by the server itself, with its own short-lived tokens.
- Postgres for tables, invites, groups and saved games.
- A local development setup: `bin/setup` once, then `bin/dev` starts Postgres and the server, `bin/dev seed` creates a family of test players, and a dev sign-in lets you play with yourself in two browser windows.
- Tables you create, invite links, a lobby where the host taps Start, and computer players to fill empty seats.

Every pull request that touched sign-in or permissions got a separate security review before it reached me, and every review found something. A deleted account could still join a table while its last login was valid. Invite codes could be guessed slowly with enough throwaway accounts. A table could end up with no host, and nobody could start it. One question the reviews raised was mine to answer: how to stop people guessing six-character invite codes without ever locking out my family. Research on how other products handle short join codes led to the answer: make a correct guess worthless. A typed code from a stranger now only creates a request the host has to approve, and invite links carry a long secret instead.

## When CI stops

In the morning, every GitHub Actions job started failing in two seconds: a billing problem on my side. Rather than wait, we made local verification the gate. `bin/test` runs every rules engine and every command-line tool in about 80 seconds, and each pull request now lists the exact commands it ran and their results. The server's database tests run against Postgres.app, because Homebrew's Postgres install kept hanging on this Mac.

I also installed the iOS simulator, and the first real run of the iPhone app found six bugs CI had never seen, because CI only built it. Error messages appeared off screen, names broke in the middle of words, and large text did nothing at all.

## The best test was playing

Then I played, and filed three issues the agents had missed:

- The melds only showed counts, not the cards.
- I couldn't add a card to my own meld of nines. The rules engine was right; the app sent a one-card meld instead of an add.
- I wanted to tap the stock to draw and tap the melds to lay cards, not hunt for buttons.

All three were fixed on iPhone, Android and the web in one pull request, with a regression test for the meld bug.

## Keeping track

With five or six agents working at once, I lost track of what was waiting for me. So we set up a GitHub Project board: everything I need to do (decisions, accounts, a real family hand to test against) is assigned to me, and the agents move their own work between columns. I stopped reading long status summaries and started looking at one column.

The one slip of the day was mine and GitHub's together. Two stacked pull requests, the invite defences and the lobby on top of them, were merged ten seconds apart, before GitHub had moved the second one onto `main`. The lobby landed on a branch that no longer led anywhere. Nothing was lost, it just needed a new pull request, and now stacked pull requests are opened against `main` from the start.

## Where it stands

After two days: around 35 merged pull requests, the rules on three platforms plus the browser, computer players, online tables with a lobby, and apps on iPhone and Android. Phase 1 has one gate left, and it's mine: a real hand from a family game, scored on paper, that the app has to score the same way.

Later I played a full game against the computer. I lost. It was still a good day.

## What I learned on day 2

Parallel work only pays off if the pieces don't step on each other. Most of my decisions today were about order: which pull request goes first, what waits for what.

Agents found plenty of problems in each other's work. The problems I found by playing were different, and more important. There is no substitute for sitting at the table.
