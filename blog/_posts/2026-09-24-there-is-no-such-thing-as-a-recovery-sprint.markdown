---
layout: post
title: "There Is No Such Thing as a Recovery Sprint"
date: 2026-09-24
author: "Eduardo Diaz Sancha"
timeToRead: "6 minutes read"
description: "Meta tripled its code output with AI and got a 40% rise in incidents. Any running coach would have called it: you don't get faster by making every day a hard day."
categories: "leadership management"
---


_Hello, this is [Eduardo](https://www.linkedin.com/in/edsancha) and I'm an Engineering Leader and Certified Running coach. Leadership Endurance is a newsletter about leadership, endurance sports, performance and growth, in the confluence of these worlds._

[Subscribe now](https://leadershipendurance.substack.com/subscribe?)

---

In my last [post](https://edsancha.com/blog/leadership/management/wellbeing/2026/09/15/the-cognitive-dissonance-of-working-in-tech-right-now.html), I wrote that being in a job that uses AI as a tool is as exciting as it's becoming mentally taxing, and how managers can help with handling this cognitive dissonance. Today, we'll be talking about the systemic consequences of this excitement and rush, and, in the same way an excited runner rushes to train for their (not always) first race and get an injury from over-training, we are starting to see the consequences at a system level from rushing into AI.

Meta spent the last year shrinking product groups of ten to twenty people into "pods" of three to five, with AI agents making up the difference. Reuters got hold of the internal numbers in August and LeadDev wrote them up. Year over year:

- Code changes: **+220%**
- Changes that became features users could actually see: **+36%**
- Major incidents: **+40%**
- Time spent firefighting those incidents: **+70%**

At the same time, Shopify's CEO Tobias Lutke, remarked that AI helps employees produce more material, faster, without taking responsibility for its quality, and calling them 'slop grenades', in fact, reducing productivity. 

Read these stories, and others lately, as an engineering leader and you see a productivity impact story with struggles keeping quality. Read it as a coach and you see an athlete who tripled their weekly mileage, dropped their physio, and is now emailing you about a sore Achilles.

I've been in both sides and every coach will tell you the same, the answer is never "run harder".

## Intensity isn't the problem. Distribution is.

Here's the thing most people get wrong about how endurance athletes train: they assume the fast ones train hard all the time. They don't. Stephen Seiler spent years measuring what elite runners, rowers, cyclists and skiers actually do, and the pattern held across every sport and every country: about 80% of their training time is easy. Genuinely easy, conversational, boring. Around 20% is hard. Almost nothing lives in the middle.

Amateurs do the opposite. Every run is a little bit hard. Never hard enough to force real adaptation, never easy enough to recover from. It feels productive (you're sweating!) and it produces exactly two outcomes: a plateau or an injury.

My own log from last year succesful attempt to run a sub3 marathon build shows this: 80% of my running time, 87% of overall exercise in the two lowest heart rate zones.

Now look at what "AI in every sprint" actually does to a team's intensity distribution. Agents don't get tired, so the temptation is to make every ticket a hard session. Bigger PRs, more of them, faster. The easy work, the reading, the verification, the "let me just trace this through before I merge it", gets squeezed out because it doesn't show up in the throughput chart. You've built a plan where everything is a tempo or intervals run. **The 220% is the tempo run. The 40% is the Achilles.**

## The load might be what it looks wrong, but the problem is how fast you got there.

Sports science has a cleaner version of this than "don't overdo it". Tim Gabbett's work on the training-injury paradox compares an athlete's *acute* load (this week) to their *chronic* load (roughly the last month). Athletes with a high chronic load are the most protected from injury, because they earned it gradually. The ones who get hurt are the ones whose acute load spikes well above what their body is used to. Across rugby, soccer and running, the danger zone starts when this week is about one and a half times the recent average.

Meta didn't add a hard session. It multiplied the acute load by three in one year *and cut the people who absorb it*. Fewer humans per pod means fewer reviewers, fewer people holding context, fewer people who know why the weird thing in the codebase is weird. It seems good in paper, but those radical changes create extra stress in the teams, it's not that the org didn't lack capacity to produce. It lacked the right adaptions to absorb what it produced.

## Incidents are the niggle companies are ignoring

Athletes rarely go from healthy to injured overnight. There's a niggle first. A tightness that's "fine once I warm up". You can run through it for a few weeks. Then one morning you can't.

Incidents and firefighting time are the niggle. And there's a nasty twist that makes the AI version harder to catch. New Relic surveyed two hundred engineering leaders this year. **94% said AI-generated code looked *higher* quality in review.** The same group: 78% saw more production incidents after that code shipped, and 86% saw senior engineers spending more time fixing it.

That gap, "looks great in review, breaks in production", is exactly the trap of judging a workout by how it felt. The session that feels fine and wrecks you the next morning is the one that gets you hurt. Review is how it felt. Production is the next morning. If your dashboard only shows the first one, you're coaching blind.

And that senior-engineer firefighting number is the one I'd watch hardest. Firefighting is the most expensive kind of work an org does, and it's done by the people you can least afford to burn. Up 70% isn't a cost of doing business. It's a stress fracture forming.

## There is no such thing as a recovery sprint

A running scientist I read pointed out something this week that annoys coaches and is nonetheless true: the "recovery run" doesn't exist. An easy run doesn't speed up recovery compared to rest. It slightly slows it. Easy runs are still valuable, they're how you carry volume without breaking, but the only thing that actually recovers you is *not running*.

Engineering has the same folklore. The "cleanup sprint". The "tech debt week". Teams schedule one after a rough quarter, still ship during it, still take interrupts, and wonder why nothing feels better afterwards. Because that's not recovery. That's an easy run with a hard-run mindset.

Recovery is a week where the throughput number is allowed to go *down*. On purpose. With the CTO's name on the decision so nobody has to defend it.

## What I'd actually do

If you're leading a team through AI adoption right now, here's the training plan. (Here's what I try to run, anyway. Results vary.)

1. **Track chronic load, not just this sprint.** Put a four-week rolling average of change volume next to the weekly number. When this week runs well above the average, and it will, expect the incident bill two to four weeks later. That lag is the whole game. If you only look at this week, you'll always be surprised.

2. **Decide which 20% is hard.** Name the sessions that are allowed to be intense: the migration, the agent-heavy feature, the launch. Everything else is easy by design. Small PRs. Verification. Tests the agent didn't write. Reading code you didn't write. Easy isn't slow. It's controlled.

3. **Put firefighting time on the dashboard.** Next to throughput, same size font, make sure to track it. It's your injury metric. If it trends up for a month, that's not a retro topic, it's a plan change.

4. **Add load like an athlete.** The old ten-percent rule is crude but it's crude in the right direction. Raise agent-driven output gradually. When incidents rise, hold the load until they settle. Then raise it again. You don't lose the gains by holding. You lose them by getting hurt.

5. **Schedule the down week.** This is something experimental, straight from the endurance world: Every fourth week or sprint, less volume. Not a cleanup sprint. A real one, where the number drops and nobody apologizes.

6. **Cut the crew last, not first.** The LeadDev piece lands on the same conclusion any coach would: if you're going to shrink teams, do it at the *end* of the transformation, after the base is built, in small experiments. Athletes don't drop their physio the week they triple their mileage. That's the week they need one most.

## The endurance summary

The goal of a training block isn't the biggest week. It's the athlete still standing at the start line, and still standing at the finish. Durability, the ability to absorb work day after day without breaking, is the thing that actually separates the runners who improve for a decade from the ones who have one great season and disappear.

AI has made it trivially easy to have a huge week. Everyone can hit 220% now. The scarce thing is the org that can hit it and still be shipping, calmly, in eighteen months.

Go easy most days. Go hard on purpose. Rest for real. It's boring advice. It's also the only kind that works.

---

_Sources: 
Chris Stokel-Walker, ["Meta tried to shrink engineering teams around AI"](https://leaddev.com/ai/meta-tried-to-shrink-engineering-teams-around-ai), LeadDev, 7 Sept 2026. Ben Shimkus, ["Shopify CEO says employees' 'slop grenades' are making more work for everyone else"](https://www.businessinsider.com/shopify-ceo-ai-slop-grenades-can-make-work-harder-2026-9), Business Insider, 17 Sept 2026. New Relic, "2026 State of AI Coding" (Hanover Research, n=200 U.S. tech decision-makers). Gabbett, ["The training-injury prevention paradox"](https://pubmed.ncbi.nlm.nih.gov/26758673/), BJSM 2016. Seiler, on intensity distribution in elite endurance athletes, ["Quantifying training intensity distribution in elite endurance athletes: is there evidence for an “optimal” distribution?"](https://www.academia.edu/144473623/Quantifying_training_intensity_distribution_in_elite_endurance_athletes_is_there_evidence_for_an_optimal_distribution). Matt Carpenter, ["There Is No Such Thing as a Recovery Run"](https://substack.com/home/post/p-217131098), The Science of Endurance, 23 Sept 2026._
