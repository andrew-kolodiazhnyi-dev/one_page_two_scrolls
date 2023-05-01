# One page two scrolls

This is an example how to use NestedScrollView if two scrolls needed in one page.

Let's imagine you need some scrollable section in the top, and then you have a paginated (scrollable) section underneath. Because you don't know how many items will be there, you can't specify height for the underneath section, and you need to scroll there as well. But it is impossible to create two scrollable sections without specifying a strict height. In this situation, you can use NestedScrollView and it will handle two scrolls sections!
