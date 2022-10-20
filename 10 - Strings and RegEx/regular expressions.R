


# What is Regular Expression (RegEx, RegExp)?
#   - simbols representing a text pattern
#   - set of rules implemented in different languages for searching, matching and replacing text
# 

# The challeng of RegEx is to match what you want and ONLY what you want.

# "matches"
# 
# History of RegEx
#   1943:
#   1956:
#   1968: Ken Thompson implements regular expression in ed, an early Unix text editor
#   
# in ED:
#     g/RegEx/p
#     grep
#     became widely used in many Unix programms like emacs, vi, awk
#     
#   1986: POSIX Portable Operating System Interface - standard to ensure compatibility
#   - Basic RegEx
#   - Extended RegEx
#   
#   1986: Henry Spencer releases a RegEx library written in C
#   
#   1987: Larry Wall releases Perl and uses Spencer's library and add many powerful features
#   Perl-compatible languages and programms: Apache, C/C++, C#,VS,.NET, Java, JavaScript, MySQL, PHP, Python, Ruby
  
grep("ar", c("something else","car"), perl=TRUE, value=TRUE) # value=TRUE
grepl("ar", c("something else","car"), perl=TRUE)
sub("ar","AR", c("something else car","car car"), perl=TRUE)
gsub("ar","AR", c("something else car","car car"), perl=TRUE)
myString <- "Learn how to find and manipulate text quickly and easily using regular expressions. Author Kevin Skoglund covers the basic syntax of regular expressions, shows how to create flexible matching patterns, and demonstrates how the regular expression engine parses text to find matches. The course also covers referring back to previous matches with backreferences and creating complex matching patterns with lookaround assertions, and explores the most common applications of regular expressions."
regexpr("h.?w",myString,perl=TRUE)
gregexpr("h.?w",myString,perl=TRUE)
regexec("how",myString,perl=TRUE)

# Modifiers:
# - Global mode - earliest match is prefered
# - Case sensitive
# - Dot matches all

# Metacharacters \ . * + - { } [ ] ^ $ | ? ( ) : ! =
  # - can have more that one meaning


#---- Wildcard metacharacter
#
# "." - dot character matches any character exept new line
# Example: "h.t" mathces "hot" and "hat" and "h9t"
# Broadest match possible

#---- Escaping metacharacters
#
# "\" - backslash character allows use of metacharacters as literal characters
# Example: "\\" matches normal \
# "\d" - backslash with non-metacharacter simbol gives them new special meaning

#---- Other Metacharacters
# Spaces " "
# Tab "\t"
# Vertical tab "\v"
# Line return "\r", "\n", "\r\n"
# ASCII or ANSI codes - 0xA9 "\xA9"


#---- Character set
# "[]" - defines the character set
# Example: [aeiouy] matches one wovel from the character set
# Character ranges is represented by "-" inside []:
# - [A-Z],
# - [a-z],
# - [A-Za-z],
# - [A-Dx-z]
# - [1-4], 
# - [0-9]

#---- Negative character set
# "^" - negative character set
# Example: [^aeiouy] - matches non-vowel
# Example: see[^mn] - matches "seek" but not "seem" or "seen"

#---- Metacharacter inside character set
# Do not need to escape metacharacters inside character set
# Example: "h[abc.xyz]t - match "h.t"
# Exceptions: ] - ^ \ - these metacharacters Sneed to be escaped
# Example: "var[[(][0-9][\])]"

#---- Shorthand for digits
# "\d" - digit - [0-9]. Example: "\d\d\d\d" - matches "1984"
 # "\w" - word character - [a-zA-Z0-9_]. Example, "\w\w\w" - matches "ABC", "123" and "1_A"
 # "\s" - whitespace - [ \t\r\n]
 # "\D" - not a digit - [^0-9]
 # "\W" - not a word - [^a-zA-Z0-9_]
 # "\S" - not a whitespace - [^ \t\r\n]
# Combinations:
 # - with hyphen - "[\w\-]"
 # - any digit or whitespace character - "[\d\s]"

#---- POSIX bracket expressions
#
# "[:alpha:]" - Alphabetic characters = "[A-Za-z]"
# "[:digit:]" - Numeric characters = "[0-9]"
# "[:alnum:]" - Alphanumeric characters = "[A-Za-z0-9]"
# "[:lower:]" - Lowercase alphabetic characters = "[a-z]"
# "[:upper:]" - Uppercase alphabetic characters = "[A-Z]"
# "[:punct:]" - Punctuation characters
# "[:space:]" - Space characters = "\s"
# "[:blank:]" - Blank characters (space, tab)
# "[:print:]" - Printable characters, spaces
# "[:graph:]" - Printable characters, no spaces
# "[:cntrl:]" - Control characters (non-printable)
# "[:xdigit:]" - Hexadecimal characters = "[A-Fa-f0-9]"
#
# Example: "[[:alpha:]]" or "[^[:alpha:]]". Incorrect - "[:alpha:]"
# Not to mix with other shorthand sets.
# Support by Perl, PHP, Ruby, Unix
# No support by Java, JavaScript, .NET, Python

## in terminal: 
# ps aux - list all the processes on Unix
# ps aux | grep --regexp="viktor"

#---- Repetition metacharacters
# - "[]*" - preceding item zero or more times
# - "[]+" - preceding item one or more times. In this case the preceding item must exist.
# - "[]?" - preceding item zero or one time

#---- Quantified repetition
# {min, max-optional}
# Example: "\d{4,8}" - matches numbers from 4 to 8 digits
# Example: "\d{4}" - matches numbers with exactly 4 digits
# Example: "\d{4,} - matches numbers with 4 or more digits
# Example: "\d{0,}" = "\d*", "\d{1,}" = "\d+"

#---- Greedy expressions
#
# Standard repetitions quantifiesr are greedy.
# Expression tries to match the longest possible string

#---- Lazy expressions
# "?" - makes greedy expressions lazy
# - "*?"
# - "+?"
# - "{min,max}?"
# - ??

#---- Grouping metacharacters
# "()" - brackets group expressions
# - apply repetition operators to a group
# - makes expression easier to read
# - captures group for use in matching and replacing
# - cannot be used inside character set
# Example: "(abc)+" - matches "abs" and "abcabcabc"
# Example: "(in)?dependent" - matches both "dependent" and "independent"

#---- Alternation metacharacters
# "|" - match previous or next expression | = or
# Example: "apple|orange" - matches both "apple" an "orange"
# Example: "abc|def|ghi" - matches "abc", "def" and "ghi"
# Example: "w(ei|ie)rd" - matches "weird" and "wierd"

#---- Anchored Expressions
# "^" - carat at the beginning of the line shows the start of the string or a line
# "$" - at the end of the line shows the end of the sthing or a line
# "\A" - start of the string and never of the end of a line
# "\Z"- end of the string and never the end of the line
# - they have zero length indicating a position, not a character
# Examples: "^apple" or "\Aapple" or "^apple$", etc.

#---- Word boundaries
# "\b" - word boundary (start/end of the word)
# "\B" - not a word boundary
# - referece a position, not a character
# - remember, word characters: [A-Za-z0-9_]

#---- Backreferences
# Grouped expressions are captured and matched portion in parentheses are stored.
# Backreferences allow access to captured data with "\1'.
# The captured expression can be used in the sampe expression as group
# Can be accessed after the match is complete
# Example: "(apples) to \1" - matches "apples to apples"
# Example: "<(i|em)>.+?</\1>" - matches "<i>Hello</i>" and "<em>Hello</em>"

#---- Non-capturing group expressions
# "(?:)" - specify a non-capturing group
# Example: "(\w+)" becomes "(?:\w+)"

#---- Positive lookahead assertions
# "(?=)" - check for the part of match but don't include it into final match
# Example: "(?=seashore)sea" - matches "sea" in seashore but not "seaside"
# "(?=seashore)sea" = "sea(?=shore)"

#---- Negative lookahead assertins
# "(?!)" - opposite to positive lookahead assertions
# Example: "(?!seashore)sea" - matches "sea" in seaside but not seashore
# "(?=seashore)sea" = "sea(?!shore)"
# "online(?! training)" does not match "online training"
# "online(?!.*training)" does not match "online video training"

#---- Lookbehind assertions
# "(?<=)" - positive lookbehind assertion
# "(?<!)" - negative lookbehind assertion
# Example: "(?<=base)ball" matches the "ball" in "baseball" but not "football"
# "(?<=base)ball" = "ball(?<=baseball)"

#---- Insertion of text using Lookahead and lookbehind assertions




