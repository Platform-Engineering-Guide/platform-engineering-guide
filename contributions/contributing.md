# Contributing to the Companion Repository

Thank you for taking the time to contribute. The most valuable 
contributions to this repository come from practitioners who encounter 
the book's content in the context of real implementation work — people 
who discover that a tool behaves differently than described, that a 
recommended practice has shifted, or that a project has changed status 
in a material way.

## What We're Looking For

**High-value contributions:**

- A tool referenced in the book has released a breaking change that 
  affects the described configuration or behaviour
- A project has changed status materially — graduated, archived, 
  acquired, or relicensed — in a way that affects the recommendation
- A specific claim in the book is factually incorrect and you can 
  demonstrate the correct information with a credible source
- A Watch This Space section has resolved in a way not yet reflected 
  in [watch-this-space.md](../errata/watch-this-space.md)
- A code example in the examples repository no longer works due to 
  upstream changes

**Out of scope:**

- General disagreements with the book's opinions that are not grounded 
  in specific implementation experience
- Corrections reflecting personal tool preferences rather than objective 
  capability differences
- Contributions that are primarily promotional for specific vendors or 
  projects
- Requests for new content or additional chapters

The book is opinionated by design. The goal of this process is to keep 
it accurately opinionated, not to neutralise its positions.

## How to Submit a Correction

1. **Check the existing errata first.** Your correction may already be 
   logged. See [errata-2026.md](../errata/errata-2026.md).

2. **Open a GitHub Issue** in the errata repository using the following the template provided or the following format:

## Section Title

Chapter and section: e.g. Chapter 6, Terraform and OpenTofu

## Book Edition

Edition: e.g 2026 First Edition

## Page Number

Page number (if known): e.g. p.73

## Description of the Issue

What the book states:
[Quote or paraphrase the relevant claim]

What is incorrect or outdated:
[Describe the discrepancy clearly and concisely]

Evidence:
[Link to official documentation, release notes, or another credible
source that supports the correction]

Environment context (if relevant):
[e.g. "observed running Crossplane 1.18 on EKS 1.31"]

## Suggested Correction

Provide corrected text if known.

## Additional Context

Optional supporting notes.

3. **For code example corrections**, open the issue in the examples repository rather than the errata repository, and include the specific file path and the corrected configuration.

## What Happens Next

Submissions are reviewed by the author. Where a correction is confirmed:

- It will be logged in [errata-2026.md](../errata/errata-2026.md) with attribution to the contributor
- Where the correction affects a Watch This Space section, it will also be logged in [watch-this-space.md](../errata/watch-this-space.md)
- Material corrections will be incorporated into the next edition, with the contributor credited in that edition's acknowledgements

Response times will vary. This is a one-person editorial operation alongside other work. Corrections with clear evidence and precise chapter references will be processed faster than vague reports.

## Attribution

Named contributions are credited in the errata log. If you would prefer to contribute anonymously, note this in your issue and your name will be omitted from the log.
