#!/usr/bin/env python

import re
import sys
try:
    import vim
except ImportError:
    sys.stderr.write("This module should be called from inside vim\n")
    #sys.exit(1)

beginDocumentRe = re.compile(r"\\begin\{document\}")
endDocumentRe = re.compile(r"\\end\{document\}")
sectionRe = re.compile(r"\\section *\{")
subsectionRe = re.compile(r"\\subsection *\{")
subsubsectionRe = re.compile(r"\\subsection *\{")
labelRe = re.compile(r"\\label *\{(.*?)\}")

def escapeSlash(string):
    return re.sub(r"\\", r"\\\\", string)

# Remove repeated spaces, newlines and so on
def normalizeString(string):
    return re.sub(" +", " ", re.sub("\n", " ", re.sub("\t", " ", string)))

def getAllBracketContents(regexpList, lines, begin=0, end=-1):
    l = begin
    if end < 0:
        end = len(lines)
    objectsFound = []
    while l < end:
        currentLine = lines[l]
        regexpToTry = 0
        startingAt = 0
        while regexpToTry < len(regexpList):
            matchObject = regexpList[regexpToTry].search(currentLine[startingAt:])
            if matchObject:
                # try to get the argument (which might be split across lines)
                argText = ""
                nParens = 1 # The opening {
                startPos = startingAt + matchObject.start()
                startLine = l
                currentPos = startingAt + matchObject.end() 
                while nParens > 0:
                    while nParens > 0 and currentPos < len(currentLine):
                        if currentLine[currentPos] == "}":
                            nParens -= 1
                        elif currentLine[currentPos] == "{":
                            nParens += 1
                        if nParens > 0:
                            argText += currentLine[currentPos]
                        currentPos += 1
                    if nParens > 0: # We need another line
                        argText += " " # Apparently the lines do not have \n at the end
                        l += 1
                        if (l < len(lines)):
                            currentLine = lines[l]
                            currentPos = 0
                        else:
                            # something is wrong with the document (exit quietly)
                            nParens = 0
                objectsFound.append((startLine, startPos, regexpToTry, normalizeString(argText)))
                startingAt = currentPos
                regexpToTry = 0
            else:
                regexpToTry += 1
        l += 1
    return objectsFound

def findAllLabels(lines, begin, end):
    labels = set() 
    for l in lines[begin:end]:
        matchObject = labelRe.search(l)
        while matchObject:
            labels.add(matchObject.group(1))
            matchObject = labelRe.search(l[matchObject.end():])
    return labels

def vimTableOfContents():
    sectioningRegexps = [sectionRe, subsectionRe, subsubsectionRe]
    startLine = 0
    beginDocumentFound = False
    while startLine < len(vim.current.buffer) and not beginDocumentFound:
        beginDocumentFound = beginDocumentRe.search(vim.current.buffer[startLine])
        if not beginDocumentFound:
            startLine += 1
    sectionings = getAllBracketContents(sectioningRegexps, vim.current.buffer, startLine)
    vim.command("let reftexList = []")
    counters = [0] * len(sectionings)
    for s in sectionings:
        vim.command("let listEntry = {}")
        vim.command("let listEntry.filename = \"%s\"" % vim.current.buffer.name) 
        vim.command("let listEntry.lnum = %d" % (s[0]+1))
        vim.command("let listEntry.col = %d" % (s[1]+1))
        counters[s[2]] += 1
        for c in range (s[2]+1, len(counters)):
            counters[c] = 0
        listEntryText = "\t" * s[2]
        for c in range(s[2]+1):
            listEntryText += "%d." % counters[c]
        listEntryText += " %s" % escapeSlash(s[3])
        vim.command("let listEntry.text = \"%s\"" % listEntryText)
        vim.command("call add(reftexList, listEntry)")
    result = vim.command("call setloclist(0, reftexList)")
    vim.command("lopen")

def vimFindAllLabels():
    labels = findAllLabels(vim.current.buffer, 0, len(vim.current.buffer))
    vim.command("let reftexLabelList = []")
    for l in labels:
        print l
        vim.command("call add(reftexLabelList, \"%s\")" % l)

#if __name__ == "__main__":
#    lines = []
#    for l in sys.stdin:
#        lines.append(l)
#    labels = findAllLabels(lines, 0, len(lines))
#    for l in labels:
#        print l
