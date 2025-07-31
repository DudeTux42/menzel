# Projektdokumentation Template (Projektarbeit und Präsentation)

Template / Dummy für Dokumenation der Projektarbeit und Abschlusspräsentation.

This repo resides in https://git.intern.b1-systems.de/trainees/abschlussarbeiten/projektdoku-template

Add your own project/repo to this folder and push your own project docu. For instance: /trainees/abschlussarbeiten/projektdoku-foobar

## A list of LaTeX packages you need

* versions
* newverbs
* bclogo

### other packages

inkscape (for compiling small graphics for info boxes. Only for the first run.) I think it would be interesting to make this with ghostscript. If you are confident in providing a makefile that uses ghostscript instead of Inkscape, please make a pull/merge-request.

## What are the sub-folders about

Folder "doku" is where the actual project documentation (the printout) goes.
Folder "presentation" is where the slides for your presentation go.

### doku (this is your project documentation)

config.tex : Set here your name and the final filename that drops out at the end of the make-process.

glossary.tex : Contains a list of descriptions. Use this for all words, that are not familiar to the commoners.
Acronyms can also go there.

#### Getting started with doku

* Change the title of the titlepage (Search for {titlepage} in kundendoku.tex)
* Change the title of the page header (Search for Kopfzeile in kundendoku.tex)
* Insert your Name and examinee number (where the titlepage in kundendoku.tex is defined)
* Change the name of the final file in config.tex

* Use `make pdf` to build the pdf file. Use `make clean` to remove all temporary files.  
  **DANGER** if you use a latex editor like texstudio or GNOMELaTeX the glossary and/or
  other features might not be compiled properly. Always use `make` to build your pdf and
  make sure everything works.

* There is a `\hyphenation`-environment for all your non-standard hyphenations. Hyphenation
  sometimes does not work with words containing special characters. In such a case use
  `Sil"-ben"-tren"-nung` within the text.
* See the \inputs for further content. All your words go there.

#### Further reading for specific topics

##### Tables, Figures, Code (Floats)
Tables, Figures (Images) and Listings (Code examples) are set with the
three environments `{table}`, `{figure}` and `{lstlisting}`.

These three are floating environments. LaTeX has its own algorithm where
to place them in the document. Usually you just let LaTeX decide. Do tewaking
only in the end when all your text is finished.

For tables and figures you should define a `\caption{}` and after or
within the caption goes a unique `\label{}`.  
See [The Wikibooks reference](https://en.wikibooks.org/wiki/LaTeX/Labels_and_Cross-referencing#Pictures).

Listings define the caption in the environments options:

```
\begin{lstlisting}[language=,
		caption={[SHORTNAME]LONG DESCRIPTION},
		%captionpos=[t|b],
		label={lst-helloworld},
		float={tbh}]
```

The SHORTNAME appears in the index (toc), the LONG DESCRIPTION
appears next to the listing in the text.  
`captionpos=` is either t or b. But usually you don’t use this option at all.

See also the [documentation of listings](https://ctan.ebinger.cc/tex-archive/macros/latex/contrib/listings/listings.pdf).

Table and Figure floats can be aligned with the [placing specifier](https://en.wikibooks.org/wiki/LaTeX/Floats,_Figures_and_Captions#Figures)
`\begin{figure}[PLACING]`

Be advised that these are just recomendations to LaTeX. Finally it decides
where to put floats. Because LATEX KNOWS.
There are, however, ways to override. Ask you local TeX-Dealer.


#### Glossary:
http://tug.ctan.org/tex-archive/macros/latex/contrib/glossaries/glossaries-user.html



### presentation (this is where your slides for your presentation and the handout goes)

#### Preparations

Copy or link the folder `texmf` to your homedir.
This folder contains the customized beamer template.
Run `texhash ~/texmf` to update your TeX-Config.

Update the following files:
* output filename in `include/config.tex`
* Title and subtitle of the presentation in `chapters/title.tex`
* Your name, Jobtitle and Email in `chapters/title.tex`

Now try to build the presentation with `make presentation && make
handout`. See section `make` below for more options.  
If it builds correctly proceed with the actual content.

#### Editing files

Edit your chapter order in `presentation.tex` and if you want to use a handout with notes, also edit your chapters in `handout.tex`. The chapter order should be the same. The handout includes by default a titlepage and a table of contents.

#### TeX Keywords

Use `\frametitle{FOOBAR}` to declare a title/headline for the slides (see chapters/agenda.tex)
Use `\section{}` and `\subsection{}` to make the logical separation.
This appears in the handout and in your section overview in your
PDF-Reader. But not in the actual slides.

The `\mode`-tag is used to automatically generate the handout-pages and separate slide content from handout content.
The following modes are available:
* `<presentation>`: This appears only on slides
* `<article>`: This appears only in the notes
* `<all>`: This appears on both

A mode may also appended to a LaTeX Keyword. By doing so, this keyword is only used for this particular mode.

Use `\setbeamertemplate{frametitle}[chapter title]` to change the
appearance of your `\frametitle{FOOBAR}`.

Use `\begin{frame}` and `\begin{block}` to structure your presentation.

Use Overlays. `<+->` and `<n->` (where n is a number). Have a look at `chapters/overlay<nn>.tex`

Use the general construct:

```
\section{for handout}} %% or \subsection{}

{%
% Optinally set the template to chapter title.
% This puts the title into the middle right side
% of the page. Used for only-title-slides.
\setbeamertemplate{frametitle}[chapter title]
\begin{frame}[fragile]

\frametitle<presentation>{Title/Headline for slides}  %% Only on slides


\mode<article>{
\includethumb
%% This is used to include the slide in the handout.
}



\mode
<presentation>

%% Anyhting from here ’till the next mode goes on the slides only

\begin{block}{Blockbuster}
Block Contents. Can also be lists and things
\end{block}

\mode
<article>

%% Anything from here ’till the next mode goes on the handout only

\mode
<all>

%% If you want something to appear on both, the slides and the handout, use this space.



\end{frame}
}%  This is brace is important. It closes the one after the \section

\newpage
```


#### make

* `make artwork` for compiling b1 specific images needed for warning and info boxes
* `make images` for compiling your images
* `make presentation` for a 4:3 presentation.
* `make presentation-169` for a 16:9 presentation (recommended).
* `make handout` for a handout with notes.
* `make handout-plain` for a handout with only the slides.

Or use `make all` for all.


#### Updating the presentation template

This step is only neccessary in case you want to update the Template after the Doku-Team changed something.
Access to Doku SVN is required. For creating your presentation this step is not required. Just for maintenance
every 5 years or so…

Get the current Beamer Theme:
`svn co https://svn.intern.b1-systems.de/documentation/documentation/templates/spielwiese/tex-beamer/texmf ~/texmf`

Get the current presentation template:
`svn co https://svn.intern.b1-systems.de/documentation/documentation/vortraege/NEWTALK/` (firmenprofil)
