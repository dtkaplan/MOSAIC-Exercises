# Run this file to create the .Rnw file.
# Then compile that file.

rnwFiles <- dir( pattern="[rR]nw$", recursive=TRUE )
inds <- grepl("Rnw-PDF-catalog.Rnw",rnwFiles)
rnwFiles <- rnwFiles[!inds]


preface <- "\\documentclass{article}\n\\usepackage{rotating}\n\\title{Statistics Problems}\n\\author{Project MOSAIC Exercises}\\date{\\today}\n\\begin{document}\n\\maketitle\n\\newpage\\"
res <- character(length(rnwFiles))
for (k in 1:length(rnwFiles)) {
  res[k] <- paste(
    paste("\\paragraph{Problem", k, "}"),
    paste("\\Sexpr{knit_child(text=readLines('",
          rnwFiles[k],
          "'))}\n",sep=""),
    "\\medskip",
    "\\subparagraph{Problem Info:}",
    "\\begin{itemize}",
    paste("\\item Argument to \\texttt{\\\\}\\texttt{Sexpr} \\tiny{\\texttt{\\{knit\\_child(text='",
             "http://dtkaplan.github.io/",
             "MOSAIC-Exercises/",
             "Statistics/",
             rnwFiles[k],
             "')\\}}}\n",sep=""),
    "\\end{itemize}\n",
    "\\newpage",
    
    sep="\n")
}
suffix <- "\\end{document}\n"
writeLines(c(preface,res,suffix), "Rnw-PDF-catalog.Rnw")

# knit("Rnw-PDF-catalog.Rnw")
