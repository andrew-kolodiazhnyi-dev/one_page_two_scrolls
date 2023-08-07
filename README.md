# One page two scrolls

This is an example how to use NestedScrollView if two scrolls needed in one page.

Let's imagine you require a scrollable section at the top, followed by a paginated (scrollable) section below. Due to the uncertainty of the number of items, specifying a fixed height for the lower section isn't feasible, necessitating scrolling within that section. However, creating two scrollable sections without specifying precise heights is a challenge. In such a scenario, the solution lies in using a NestedScrollView, which adeptly manages both scrollable sections simultaneously.

#### Hard-coded strings are used for simplicity (Do not use this approach in real projects)
