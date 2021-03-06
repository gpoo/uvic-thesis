%   Copyright (C) 2014--2015 Ross Churchley
%
%   License
%   =======
%
%   This work may be distributed and/or modified under the conditions of
%   the LaTeX Project Public License, either version 1.3 of this license
%   or (at your option) any later version. The latest version of this
%   license is in:
%
%      http://www.latex-project.org/lppl.txt
%
%   and version 1.3 or later is part of all distributions of LaTeX version
%   2005/12/01 or later.
%
%   This work consists of the file uvicthesis.cls and template.tex.
%
%   This work has the LPPL maintenance status `maintained'. The Current
%   Maintainer is Ross Churchley.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uvicthesis}[2015/07/10 UVic Thesis/Dissertation Template]


%   BASE CLASS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   uvicthesis.cls is based on the standard `book` document class.
%   For more information (including standard class options), see
%   http://texdoc.net/texmf-dist/doc/latex/base/classes.pdf
%   or type `texdoc book` on the command line.
%
%   The UVic Library has moved to digital-only thesis submission and no longer
%   requires print copies of theses be submitted. However, if you do want to
%   print your thesis, you can use the `bound` or `twoside` option to set
%   margins for book binding.
%

\RequirePackage{etoolbox}
\newtoggle{bound}

\DeclareOption{bound}{\toggletrue{bound}}
\DeclareOption{twoside}{\toggletrue{bound}}

\iftoggle{bound}{
    \PassOptionsToClass{twoside}{book}
}{%else
    \PassOptionsToClass{oneside}{book}
}

\PassOptionsToClass{12pt}{book}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions

\LoadClass{book}


%   FONTS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Use the Latin Modern implementation of Computer Modern, for better support
%   of diacritics and non-English glyphs, including correct PDF search.
%   The fontenc package ensures proper hyphenation of accented words.
%

\RequirePackage{lmodern}
\RequirePackage[T1]{fontenc}


%   MARGINS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Sets margins according to the UVic thesis requirements.
%

\RequirePackage[top=1.3in,left=1.5in,bottom=1in,right=1in,headsep=0.5in]{geometry}


%   LINE SPACING & PAGINATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Sets doublespacing for the document body. (This does not affect spacing
%   inside figures, tables, and other floats, which remain single-spaced.)
%
%   Provides commands to set page numbers in roman numerals for preliminary
%   pages (frontmatter) and arabic numbers for all other content (mainmatter).
%
%   Sets the page number in the top right corner of all pages by default.
%

\RequirePackage{setspace}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}

\newcommand{\defaultspacing}{\doublespacing}
\newcommand{\smallspacing}{\onehalfspacing}
\renewcommand{\frontmatter}{\smallspacing\pagenumbering{roman}}
\renewcommand{\mainmatter}{\clearpage\defaultspacing\pagenumbering{arabic}}

%   Fixes spacing for chapter titles
\titleformat{\chapter}[display]{\Huge\bfseries}{\@chapapp \  \thechapter}{0pt}{}{}

\setlength{\headheight}{15pt}
\fancypagestyle{plain}{%
        \fancyhf{}
        \fancyhead[R]{\thepage}
        \renewcommand{\headrulewidth}{0pt}
        \renewcommand{\footrulewidth}{0pt}
}
\pagestyle{plain}



%   TITLE PAGE  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Generates a correctly-formatted title page, provided the following
%   information is given in the preamble:
%
%   \title{...}
%   \author{...}
%   \previousdegrees{...}
%   \thesistype{...}
%   \degree{...}
%   \department{...}
%   \copyrightyear{...}
%
%   The ``all rights reserved'' text may also be overrided with
%   \copyrightnotice{...}
%

\renewcommand{\maketitle}{{%
    \thispagestyle{empty}
                    \begin{center}
                        \@title                             \\[12pt]
                          by                                \\[12pt]

                        \@author                            \\
                  \@previousdegrees                         \\[12pt]


  A {\@thesistype} Submitted in Partial Fulfillment of the  \\
            Requirements for the Degree of                  \\[12pt]

               \MakeUppercase{\@degree}                     \\[12pt]

                 in the \@department
                                                            \vfill


        \textcopyright\ \@author, \@copyrightyear           \\
               University of Victoria                       \\[12pt]

                 \@copyrightnotice
                    \end{center}
    \newpage
}}

%   The implementation creates a new "variable" for each metadata needed,
%   initially storing placeholder text and an instruction to throw a warning
%   if the user hasn't provided the correct information. We then define the
%   user-facing commands to set the corresponding variables when called.

\newcommand{\@thesistype}{THESIS \@MissingMetadata{thesistype}}
\newcommand{\@previousdegrees}{PREVIOUS DEGREES \@MissingMetadata{previousdegrees}}
\newcommand{\@degree}{DEGREE \@MissingMetadata{degree}}
\newcommand{\@department}{DEPARTMENT \@MissingMetadata{department}}
\newcommand{\@copyrightyear}{YEAR \@MissingMetadata{copyrightyear}}
\newcommand{\@copyrightnotice}{%
    All rights reserved. This \MakeLowercase{\@thesistype} may not be reproduced in whole or in part, by photocopying or other means, without the permission of the author.
}

\newcommand{\@MissingMetadata}[1]{\ClassWarning{uvicthesis}{%
    Missing #1. Set this in the preamble to fix your frontmatter.
}}

\newcommand{\previousdegrees}[1]{\renewcommand{\@previousdegrees}{#1}}
\newcommand{\thesistype}[1]{\renewcommand{\@thesistype}{#1}}
\newcommand{\degree}[1]{\renewcommand{\@degree}{#1}}
\newcommand{\department}[1]{\renewcommand{\@department}{#1}}
\newcommand{\copyrightyear}[1]{\renewcommand{\@copyrightyear}{#1}}
\newcommand{\copyrightnotice}[1]{\renewcommand{\@copyrightnotice}{#1}}


%   COMMITTEE PAGE  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Generates a correctly formatted committee page, provided a commitee is
%   given in the preamble as follows:
%
%   \committee{
%       \member{Name}{Supervisor}{Department}
%       \member{Name}{Role on Committee}{Department}
%   }
%
%   To display the committee, invoke \makecommittee.
%


\newcommand{\makecommittee}{
    \addtoToC{Supervisory Committee}
                    \begin{center}
                        \@title                             \\[12pt]
                          by                                \\[12pt]

                        \@author                            \\
                   \@previousdegrees                        \\[12pt]
                      \end{center}                          \vfill

    \noindent Supervisory Committee                         \\[12pt]
    \@committee                                             \vfill
    \newpage
}

%   Implementation: Have \@committee store the committee, \committee set it,
%   and \chair and \member format its contents.

\newcommand{\@committee}{}
\newcommand{\committee}[1]{\renewcommand\@committee{#1}}
\newcommand{\member}[3]{\noindent #1, #2\\(#3)\\[12pt]}


%   ABSTRACT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Redefines the abstract environment to set it on its own page together with
%   the supervisory committee again.
%

\newenvironment{abstract}{%
    \addtoToC{Abstract}

    \noindent \textbf{Supervisory Committee}                \\[12pt]
    \@committee

    \begin{center}\textbf{ABSTRACT}\end{center}

    }{\clearpage}


%   TABLE OF CONTENTS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Fixes some display issues for the table of contents.
%   Provides a command to add sections like the bibliography to the ToC.
%

\RequirePackage{tocloft}
\RequirePackage[titletoc]{appendix}
\renewcommand{\contentsname}{Table of Contents}

\newcommand{\addtoToC}[1]{\addcontentsline{toc}{chapter}{#1}}

\renewcommand{\cfttabpresnum}{Table\ }
\renewcommand{\cfttabnumwidth}{0.75in}
\renewcommand{\cftfigpresnum}{Figure\ }
\renewcommand{\cftfignumwidth}{0.90in}


%   DEDICATION AND ACKNOWLEDGEMENTS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Provides environments for optional dedication and acknowledgements pages.
%

\newenvironment{dedication}{%
    \addtoToC{Dedication}
    \chapter*{Dedication}
    }{\newpage}

\newenvironment{acknowledgements}{%
    \addtoToC{Acknowledgements}
    \chapter*{Acknowledgements}
    }{\newpage}


%   APPENDICES  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%
%
%   Prevent book class from removing lettering from appendix chapters.
%

\renewcommand{\backmatter}{\clearpage}


%   HYPERREF SETUP  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   If the user loads hyperref, make sure that links to (e.g.) frontmatter
%   sections point to the correct page and that autoreferences to appendices
%   display correctly.
%

\AtBeginDocument{%
    \@ifpackageloaded{hyperref}{%
        \pretocmd{\addtoToC}{\phantomsection{}}{}{}
        \newcommand{\Appendixautorefname}{Appendix}
    }{}
}


\endinput
