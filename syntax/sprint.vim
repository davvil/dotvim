syntax clear

syntax keyword sprintInclude include
highlight link sprintInclude Include

syntax match sprintBlock /\[.*\]/
highlight link sprintBlock Label

syntax match sprintComment /#.*$/
highlight link sprintComment Comment

syntax match sprintVariable /\$(.*)/
highlight link sprintVariable Identifier
