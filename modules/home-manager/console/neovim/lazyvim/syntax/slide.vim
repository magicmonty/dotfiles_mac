if exists("b:current_syntax")
  finish
endif

syn match Special "https://.*"
syn match Constant " \- .\+"
syn match @text.literal " \* "
syn match Error "\\  \\ | /  /"
syn match Error "\\  \\ /  /"
syn match Error "|   |"
syn match Error "\\  V  /"
syn match Error "\\[ ]\+$"
syn match Error "\\[ ]\+|[ ]*$"
syn match Error "[ ]\+|  /[ ]*$"
syn match Error "^[ ]\+|[ ]\+$"
syn match Special "----"
syn match @markup.raw "`.*`" 
syn match @markup.heading.3 "### .*"
syn match @markup.heading.2 "## .*"
syn match @markup.heading.1 "# .*"
syn match @markup.strong "\*\*.*\*\*"
