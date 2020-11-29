---
title: "Getting Started with Fedora QA - Part 1"
date: 2020-04-07T17:29:03+05:00
tags: ["fedora", "qa", "foss", "fedora-qa"]
categories: ["fedora"]
featured_image: /images/posts-static/getting-started-with-fedora-qa/cover.png
---

> <center>"No Code is Bug Free"</center>

## What is SQA (Quality Assurance) ?

According to [Wikipedia](https://en.wikipedia.org/wiki/Software_quality_assurance) : **Software quality assurance (SQA)** is a means of monitoring the software engineering processes and methods used to ensure proper quality. SQA encompasses the entire software development process, including requirements definition, software design, coding, code reviews, source code control, software configuration management, testing, release management and product integration. It is organized into goals, commitments, abilities, activities, measurements and verification.

By simplifying, Software Quality Assurance is a way to ensure that the Code/Software that a developer has written has been tested across different mediums and produces the expected results.

## Why Quality Assurance is an essential component for Fedora Project

Fedora is an Open Source Linux distribution Operating System which releases once in every six months and as a result the environment becomes very fast paced and that could make things break among general users of the distro, to prevent that to happening to users & to make sure everything works as expected, Quality Assurance is a must in Fedora Project. In Fedora, we have to encompass the user experience as there are thousands and thousands of people who expect a more stable & feature enriched OS that gets better with each release.

## Fedora Release Cycle
Before we jump into practical tools, let's have a quick introduction to how the process works

![Fedora Release Cycle](/images/posts-static/getting-started-with-fedora-qa/fedorareleasecycle.png#align:left)

The above diagram displays a clear demonstration of how Fedora creates it's release

It includes these branches: 

**Rawhide** serves as the upstream for the release branch, it's a bleeding edge, non freezing branch where contributors consitently push their packages, after a time slice we branch out different necessary packages and the Rawhide keeps on growing.

**Branched Release** is the version which gets branched out from the ongoing Rawhide & starts to get tested & refines for the release. As we reach this point, the QA team gets hands on with it :)

## Prerequisites

### FAS ID : [https://admin.fedoraproject.org/accounts/](https://admin.fedoraproject.org/accounts/)
A FAS (Fedora Account System) account is essential for you to get login access to all subprojects in Fedora with the same user ID and passwords.

### Bugzilla : [https://bugzilla.redhat.com/](https://bugzilla.redhat.com/)
Bugzilla serves as the bug tracking system for Fedora Project, with Bugzilla you can create & verify bugs along with fixing some! :)

**To register on Bugzilla**, We recommend using your `@fedoraproject.org` email Alias, because in different places for QA you would require it.

**NOTE** : If you don't have a `@fedoraproject.org` email Alias, We have a good news for you, you can reach out to us on [Fedora Join](https://docs.fedoraproject.org/en-US/fedora-join/) and we can provide you a temporary membership, which would give you the ability to attain your email Alias.


After setting up your accounts, you can reach out to the *QA Team* on **IRC**, As it's the place where most of the QA team is available, The channel for Fedora QA is: `#fedora-qa` and for Matrix users, It's: `#freenode_#fedora-qa:matrix.org`

Another alternative to IRC, is mailing lists where you can have discussions with Fedora QA team, in case if you need any clarification or being faced by issues. Mailing list requires you to subscribe to it before you can post/ask/talk. The fedora QA mailing list resides here : [test](https://lists.fedoraproject.org/admin/lists/test.lists.fedoraproject.org/) 

To subscribe to the mailing list you would need a FAS ID too.

Best of luck for starting QA with Fedora Project.

The next post would be more about getting involved and hands on with QA.

---

Thank You for reading, if you have any doubts or questions feel free to reach out to me here : [Contact](/contact/)
