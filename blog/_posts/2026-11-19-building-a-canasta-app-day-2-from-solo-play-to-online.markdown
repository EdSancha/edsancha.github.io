---
layout: post
title: "Building a Canasta App with Our House Rules, Day 2: From Solo Play to Playing Online"
date: 2026-11-19
author: "Eduardo Diaz Sancha"
timeToRead: "8 minutes read"
description: "On day two the Canasta app got computer players, a web version running the same Rust rules engine, online tables with a lobby, saved games, and its first real game, which I lost."
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

Later I played a full game against the computer. I lost. It was still a good day, and it wasn't over.

## The evening shift

In the evening the agents kept going, and I kept merging in between other things.

**Saving games.** A solo game now saves after every move, on iPhone, Android and the web, and "Continue game" brings back the same table. The same means the computer players too: their memory of what was discarded and their random state are in the save. A test proves, on all three platforms, that a game saved, loaded and played on ends exactly like one that was never interrupted. Online tables use the same format, so a table restored after the server restarts carries on as if nothing happened.

**Online, the small things.** Players choose the name the table shows. There's a "Your tables" list, a way to withdraw a request to join, and online you now see your own meld points and can sort your hand. Both stay private to you; nobody else at the table receives them.

**Security reviews, again.** Every one found something:
- A save file edited by hand could crash the app at launch. Loading a save now checks that the game it describes is possible, starting with the right number of cards. A quick fuzz of altered saves found two more crashes, and those are fixed too.
- A name made of invisible characters showed as blank, and "Abuela" with a zero-width space in it could pass for Abuela at the table. Names now have to contain something you can see.
- A leaked Apple sign-in code could have attached someone's Apple account to the wrong player. The server now keeps the Apple token only if Apple confirms it belongs to the person signing in.

**My mistake.** I merged the Apple sign-in pull request while its security fixes were still being made, so they missed it and needed a follow-up pull request. The rule now is that a pull request goes back to draft while it's being fixed. If it says ready, it's safe to merge.

**Screenshots.** I asked for one screenshot of a game in progress on each platform. The iPhone looked right. Android cut off a long meld at the edge of the screen. The web was the roughest: the scores showed a slashed zero (the font only has that one), the two rows of my hand overlapped, and on a laptop screen the pile sat below the fold. Now every pull request that changes a screen comes with before and after screenshots, and Claude checks them before it reaches me. Two went back for another round because of what the screenshots showed.

**Two small design calls.** Sorting the hand is now a dropdown on every platform instead of a row of buttons. And I removed the little green dots that marked cards you could meld, because nobody would know what they meant without being told. They might come back as part of a "beginner aids" setting.

**The disk, again.** With three agents building at once, free space on the Mac fell to 150 MB at one point. The worktrees, the separate copies of the repo each agent works in, now live on an external SSD. That's now the rule for all my projects, not just this one.

**A flaky test that wasn't flaky.** One online test failed now and then. It wasn't a race in the app. Every simulated player in the tests connects from the same address, so they kept hitting the server's own rate limits, the ones meant to slow down people guessing invite codes. The defences worked; my tests were the attacker.

## Where it stands

After two days: about 50 merged pull requests. The rules run on three platforms plus the browser, with computer players, saved games, and online tables with names, invites and a lobby, on iPhone, Android and the web. Everything runs on my Mac. What's left before family can play is mostly mine: hosting and a web address, the Apple and Google developer accounts, the sign-in keys, and a real hand from a family game, scored on paper, that the app has to score the same way.

## What I learned on day 2

Parallel work only pays off if the pieces don't step on each other. Most of my decisions today were about order: which pull request goes first, what waits for what.

Agents found plenty of problems in each other's work. The problems I found by playing were different, and more important. There is no substitute for sitting at the table.

Screenshots are the next best thing. Tests check that the app works; a screenshot shows whether it looks right.

"Ready for review" has to mean safe to merge. The one time it didn't, I merged it.
