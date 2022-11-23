# What is the project?

stakeholders:
a company developing concurrent software who wants to test it

- devs
- testers (different from devs?)
- managers

- takes too long to run tests on every commit
	- latency is important rather than just throughput, preventing horizontal scaling
- traces take up too much drive space
	- why would they store more than one set at a time? 
	- this seems unlikely

I dont know if I'm doing it wrong or my brain just doesn't work this way, but I cannot work forwards from stakeholders like this, only backwards from the problem definition.

---

**problem**: an existing codebase might contain data races, and it's hard to test for that

**solution**: run unit tests to determine addresses touched by each test, and analyse overlap

- is this a good solution? how much does it depend on coverage? any examples in literature of this approach?

**problem**: too much time/space spent generating traces for concurrent software as traces fully regenerated on commit

**solution**: only generate traces which may be different in new version

**problem**: that's not computable in general

**solution**: 

- approximate it -- what things can we prove _aren't_ changed? 
- locals, non-shared memory, memory not shared with changed code directly/indirectly 
	- construct graph?
	- use existing tool(s) where possible/practical
- improve approximation based on partial computation? 


more detailed workflow:

- change pushed to github, triggers webhook
- pull to test environment, run tests, generate traces
	- e.g. DynamoRio, LLVM interrpreter, PIN, Valgrind
- analyse traces
	- eg Eraser-Lockset, other algorithms are available (could even use multiple)
- conclude it either _does_ contain races, or it _might not_ contain races
	- cant prove absence in non-trivial cases
	- may report this info using github api

**Constraints**:

- must _save time_
	- ie determining which tests to run must take less time than simply running them all
	- if analysis is non-linear in trace size this becomes easier to meet
- targeting C/C++
	- wouldn't make sense to use interpreted languages, because that'd break tracing, or something like rust, which disallows races (in theory)
		- some tools might be language agnostic but probably most target a single language
- no false positives
	- this would be _really_ annoying and defeat the point of the tool
- minimise false negatives
	- obviously can't catch everything, but shouldn't meaningfully reduce the catch rate below what a brute force approach would achieve
	- might make devs think they solved a bug if they instead made a change that doesn't affect it  (so it wasn't re-run)
- scalable?
	- scalability likely depends only on performance of tools chosen
	- overlaps a lot with saving time


---




---

what if the partial generation upsets the analysis tool (eg false positive/negatives)