%%
%% Copyright (c) 2014 Shin'ya Ueoka <ibenza@i-beam.org>
%%

\NeedsTeXFormat{pLaTeX2e}
\ProvidesClass{jletteraddress}

\LoadClass[]{article}

\usepackage{plext}
\usepackage{xstring}
\usepackage{ifthen}
\ifx\kanjiskip\undefined\else
    \usepackage{atbegshi}
    \ifx\ucs\undefined
        \ifnum 42146=\euc"A4A2
            \AtBeginShipoutFirst{\special{pdf:tounicode EUC-UCS2}}
        \else
            \AtBeginShipoutFirst{\special{pdf:tounicode 90ms-RKSJ-UCS2}}
        \fi
    \else
        \AtBeginShipoutFirst{\special{pdf:tounicode UTF8-UCS2}}
    \fi
    \usepackage[dvipdfmx]{hyperref}

    %% Set a paper size for dvipdfmx
    \special{papersize=100truemm,148truemm}
\fi

%% Layouts
\setlength{\hoffset}{-1truein}
\setlength{\voffset}{-1truein}
\setlength{\oddsidemargin}{0pt}
\setlength{\evensidemargin}{0pt}
\setlength{\topmargin}{0pt}
\setlength{\topmargin}{0pt}
\setlength{\headheight}{0pt}
\setlength{\headsep}{0pt}
\setlength{\paperwidth}{100truemm}
\setlength{\paperheight}{148truemm}

\setlength{\tabcolsep}{0pt}
\setlength\tabbingsep{0pt}
\setlength{\unitlength}{1truemm} %

%% Sender macros
\def\sendername#1{\gdef\@sendername{#1}}
\def\senderpostcode#1{\gdef\@senderpostcode{#1}}
\def\senderaddressa#1{\gdef\@senderaddressa{#1}}
\def\senderaddressb#1{\gdef\@senderaddressb{#1}}

%% Make a address-side
\newcommand{\addaddress}[8] {
    % #1 : Receiver name
    % #2 : Receiver name suffix
    % #3 : Receiver postcode
    % #4 : Receiver address 1
    % #5 : Receiver address 2
    % #6 : Receiver name2
    % #7 : Receiver name3
    % #8 : Receiver name4

    \clearpage
    \refstepcounter{section}
    \addcontentsline{toc}{section}{#1}
    \noindent %
    \begin{picture}(100,148)(0,0)%
        % 郵便番号
        \put(43,136){ %
            \vtop to 8truemm{\vfil\hbox{\fontsize{15pt}{0pt}\selectfont%
                        \hbox to 7truemm{\hfil\StrChar{#3}{1}\hfil}%
                        \hbox to 7truemm{\hfil\StrChar{#3}{2}\hfil}%
                        \hbox to 7truemm{\hfil\StrChar{#3}{3}\hfil}\hskip0.4truemm
                        \hbox to 6.8truemm{\hfil\StrChar{#3}{4}\hfil}%
                        \hbox to 6.8truemm{\hfil\StrChar{#3}{5}\hfil}%
                        \hbox to 6.8truemm{\hfil\StrChar{#3}{6}\hfil}%
                        \hbox to 6.8truemm{\hfil\StrChar{#3}{7}\hfil}%
                    }\vfil}}

        % 住所1
        \put(83,120){\fontsize{15pt}{0pt}\selectfont%
            \parbox<t>[t]{90truemm}{#4}}

        % 住所2
        \put(75,120){\fontsize{15pt}{0pt}\selectfont%
            \parbox<t>[t]{90truemm}{\hfil#5}}

        % ここから名前
        \ifthenelse{\equal{#6}{}}
        {
            \put(50,120){
                \kanjiskip=.3zw
                \fontsize{25pt}{0pt}
                \selectfont%
                \parbox<t>[t]{90truemm}{
                    \hfil#1
                    \hskip1zw#2
                }
                \hfil
            }
        }
        % else 
        {
            \ifthenelse{\equal{#7}{}}
            {
                \put(45,120){
                    \kanjiskip=.3zw
                    \fontsize{25pt}{0pt}
                    \selectfont%
                    \parbox<t>[t]{90truemm}{
                        \hfil#6
                        \hskip1zw#2
                    }
                    \parbox<t>[t]{90truemm}{
                        \hfil#1
                        \hskip1zw#2
                    }
                    \hfil
                }
            }
            % else
            {
                \ifthenelse{\equal{#8}{}}
                {
                    \put(40,120){
                        \kanjiskip=.3zw
                        \fontsize{23pt}{0pt}
                        \selectfont%
                        \parbox<t>[t]{90truemm}{
                            \hfil#7
                            \hskip1zw#2
                        }
                        \parbox<t>[t]{90truemm}{
                            \hfil#6
                            \hskip1zw#2
                        }
                        \parbox<t>[t]{90truemm}{
                            \hfil#1
                            \hskip1zw#2
                        }
                        \hfil
                    }
                }
                % else
                {
                    \put(33,120){
                        \kanjiskip=.3zw
                        \fontsize{23pt}{0pt}
                        \selectfont%
                        \parbox<t>[t]{90truemm}{
                            \hfil#8
                            \hskip1zw#2
                        }
                        \parbox<t>[t]{90truemm}{
                            \hfil#7
                            \hskip1zw#2
                        }
                        \parbox<t>[t]{90truemm}{
                            \hfil#6
                            \hskip1zw#2
                        }
                        \parbox<t>[t]{90truemm}{
                            \hfil#1
                            \hskip1zw#2
                        }
                        \hfil
                    }
                }
            }
        }


        \put(25,85){\fontsize{12pt}{0pt}\selectfont%
            \parbox<t>[t]{55truemm}{\@senderaddressa}}

        \put(19,85){\fontsize{12pt}{0pt}\selectfont%
            \parbox<t>[t]{55truemm}{\@senderaddressb}}

        \put(10,85){\kanjiskip=0.3zw\fontsize{15pt}{0pt}\selectfont%
            \parbox<t>[t]{55truemm}{\hfil\@sendername}\hfil}

        % 自分の郵便番号
        \put(4.5,25){ %
            \vtop to 6.5truemm{\vfil\hbox{\fontsize{12pt}{0pt}\selectfont%
                        \hbox to 4truemm{\hfil\StrChar{\@senderpostcode}{1}\hfil}%
                        \hbox to 4truemm{\hfil\StrChar{\@senderpostcode}{2}\hfil}%
                        \hbox to 4truemm{\hfil\StrChar{\@senderpostcode}{3}\hfil}\hskip1truemm %
                        \hbox to 4truemm{\hfil\StrChar{\@senderpostcode}{4}\hfil}%
                        \hbox to 4truemm{\hfil\StrChar{\@senderpostcode}{5}\hfil}%
                        \hbox to 4truemm{\hfil\StrChar{\@senderpostcode}{6}\hfil}%
                        \hbox to 4truemm{\hfil\StrChar{\@senderpostcode}{7}\hfil}%
                    }\vfil}}
    \end{picture} %
}

