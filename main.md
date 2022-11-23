---
title: Capturing Concurrency Aspects of Software Under Development To Reduce Testing Effort
---

\centerline{\Large \emph{A Part III project proposal}}
\vspace{1em}
\centerline{\large M. Hood (\emph{mh2158}), Fitzwilliam College}
\vspace{1em}
\centerline{\large Project Supervisor: Prof D. J. Greaves}
\centerline{\large Project Originator/Co-Supervisor: Dr J. Jahić}
\vspace{1em}


# Abstract {-}

Writing tests to check for data races in concurrent software is challenging due to the exponential growth of possible interleavings as code size and thread count increase. There exist algorithms to find concurrency bugs given a trace of accessed memory locations, but running the entire test suite after every change to generate these traces can be slow and, especially for small changes, unnecessary.

By exploiting the knowledge that the previous iteration found no data races, this project aims to reduce both execution time and the size of newly generated traces by culling redundant tests.

# Introduction, approach and outcomes {-}

Concurrency in software is becoming increasingly prevalent, but testing for bugs is much more complex. Unit tests, the de-facto standard for sequential code, are ineffective at catching errors caused by interleavings with other threads due to the huge number of possible interleavings, and possible combinations of functions and data, only a tiny fraction of which may trigger erroneous behaviour.

Protecting shared memory with locks avoids potentially harmful interleavings. However, programmers may not always use locks correctly, leading to data races. Unintended data races are a significant source of bugs. Statically detecting data races is possible[@RELAY]\ [@RacerX], but suffers from low accuracy. Dynamic detection involves instrumenting the execution of the program while running tests to collect a trace of memory accesses, from which it is possible to more accurately detect races[@eraser].

This approach was explored in [@deterministic], which notes that trace coverage, and therefore the set of detected races, varies from run-to-run depending on thread interleavings, and proposes a method for deterministically dynamically detecting races even in the presence of changes to the source code. However, running the entire test suite to generate these traces may consume a significant amount of processor time and disk space.

This project proposes that, by analysing the propagation of possible changes to program behaviour a commit can have, in particular the set of tests which can observe this change, the number of tests needed to be re-run can be decreased, especially in the case of minor changes.

The project will produce a piece of software. It should monitor a Git repository for changes, and when a commit is made, should compute an approximation of the minimum set of required tests to be run; run them, generating traces using an existing tracing tool; and feed the traces into the Eraser-Lockset algorithm[@eraser] (or similar algorithm) to potentially alert the developers of the presence of data races.


# Workplan {-}

To ensure the originality of the project, and to best find similar approaches from which to draw inspiration, a Systematic Literature Review[@kitchenham2007guidelines] should be performed.

Precisely which methods should be used to propagate changes in memory access patterns between commits is subject to discovery based on results of the literature review, but will likely involve using a combination of existing and novel techniques to improve the approximation. I have labelled this work "core" in the below schedule.

Before core work can begin, a suitable tool for instrumentation must be found, and a prototype, including an example concurrent project to evaluate using, must be established. I estimate this initial experimentation phase should last approximately two work packets.

The project should:

- Use static analysis to build a concurrent model of software
	- identify threads, shared memory, synchronisation mechanisms
	- reason about potential concurrent control flows
- Use dynamic analysis to verify the static model
	- execute tests to product trace used for verification
- Update the static model on every change to the source code
	- reason as to whether the change affects concurrent behaviour
	- identify tests which do not need to be re-run

Core work will involve, but is not limited to:

- Identifying existing tools/methods for static analysis
- Evaluating tools for creating execution traces
	- e.g. DynamoRio, LLVM interrpreter, PIN, Valgrind
- Integrating created software into a Git workflow
	- e.g. using webhooks

A chunk-by chunk breakdown can be seen as followed:

- November 25: Systematic literature review
- December 9: Evaluation of tracing mechanisms
- December 23: Christmas holiday
- January 6: Prototype without test culling
- January 20: Core work
- February 3: Core work
- February 17: Core work
- March 3: Core work
- March 17: Core work
- March 31: Core work
- April 14: Write-up
- April 28: Write-up
- May 12: Left empty for contingencies

# Bibliography {-}