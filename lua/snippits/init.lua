local M = {}

M.setup = function()
  local ls = require("luasnip")
  local snip = ls.snippet
  local node = ls.snippet_node
  local t = ls.text_node
  local i = ls.insert_node
  local func = ls.function_node
  local choice = ls.choice_node
  local dynamicn = ls.dynamic_node

  local fmt = require("luasnip.extras.fmt").fmt
  local fmta = require("luasnip.extras.fmt").fmta
  local rep = require("luasnip.extras").rep
  local l = require("luasnip.extras").lambda
  local m = require("luasnip.extras").match

  local postfix = require("luasnip.extras.postfix").postfix

  ls.add_snippets(nil, {

    tex = {

      -- words
      snip("eqm", t("equilibrium")),
      snip("SBWC", t("Suppose by way of contradiction")),

      -- greek
      snip(";a", t("\\alpha")),
      snip(";b", t("\\beta")),
      snip(";g", t("\\gamma")),
      snip(";G", t("\\Gamma")),
      snip(";d", t("\\delta")),
      snip(";D", t("\\Delta")),
      snip(";e", t("\\epsilon")),
      snip(";vp", t("\\varepsilon")),
      snip(";z", t("\\zeta")),
      snip(";e", t("\\eta")),
      snip(";t", t("\\theta")),
      snip(";T", t("\\Theta")),
      -- snip(";o", t("\\iota")),
      snip(";i", t("\\iota")),
      snip(";k", t("\\kappa")),
      snip(";l", t("\\lambda")),
      snip(";L", t("\\Lambda")),
      snip(";m", t("\\mu")),
      snip(";n", t("\\nu")),
      snip(";x", t("\\xi")),
      snip(";X", t("\\Xi")),
      snip(";p", t("\\pi")),
      snip(";P", t("\\Pi")),
      snip(";r", t("\\rho")),
      snip(";s", t("\\sigma")),
      snip(";S", t("\\Sigma")),
      snip(";vs", t("\\varsigma")),
      snip(";t", t("\\tau")),
      snip(";u", t("\\upsilon")),
      snip(";U", t("\\Upsilon")),
      snip(";ph", t("\\phi")),
      snip(";Ph", t("\\Phi")),
      snip(";vph", t("\\varphi")),
      snip(";c", t("\\chi")),
      snip(";ps", t("\\psi")),
      snip(";Ps", t("\\Psi")),
      snip(";o", t("\\omega")),
      snip(";O", t("\\Omega")),

      -- math modes
      snip({
        trig = "mi",
        namr = "inline_math",
        dscr = "Inline ($) math environment",
      }, {
        t("$ "),
        i(1),
        t(" $"),
        i(0),
      }),

      snip(";", fmt("${}${}", { i(1), i(2) })),

      snip(
        {
          trig = "md",
          name = "display_math",
          dscr = "Display ($$) math environment",
        },
        fmt(
          [[
        $$
            {1}
        $$
        ]],
          { i(1) }
        )
      ),

      -- environments
      snip("tx", fmta("\\text{<>}", { i(1) })),
      snip(
        {
          trig = "beg",
          name = "begin",
          dscr = "Begin environment",
        },
        fmt(
          [[
        \begin{{{1}}}
            {2}
        \end{{{3}}}
        ]],
          { i(1, "align*"), i(2), rep(1) }
        )
      ),

      snip("al", t("align")),
      snip("as", t("align*")),

      snip(
        ";be",
        fmt(
          [[
        $$ \begin{{{1}}}
           {2}
        \end{{{3}}} $$
        ]],
          { i(1, "align*"), i(2), rep(1) }
        )
      ),

      snip("it", fmta("\\intertext{<>}", { i(1) })),
      snip("q", t("\\quad")),
      snip("pb", t("\\pagebreak")),

      postfix(".hat", { l("\\hat{" .. l.POSTFIX_MATCH .. "}") }),
      postfix(".bar", { l("\\bar{" .. l.POSTFIX_MATCH .. "}") }),

      snip( -- FIX: can't get this to work with fmt()
        "seq",
        { t("{"), i(1, "x"), t("}_{"), i(2, "1"), t("}, \\ldots, {"), rep(1), t("}_{"), i(3, "n"), t("}") }
      ),

      -- basic maths
      snip("_", fmt("_{{{1}}}", { i(1) })),
      snip("^", fmt("^{{{1}}}", { i(1) })),
      snip("f", fmt("\\frac{{{1}}}{{{2}}}", { i(1), i(2) })),
      snip("o", t("\\circ")),
      snip("ab", fmt("\\left\\vert {} \\right\\vert", { i(1) })),
      snip("nm", fmt("\\Vert {} \\Vert", { i(1) })),
      snip("v", t("\\vert")),
      snip("V", t("\\Vert")),
      snip("pd", fmt("\\frac{{\\partial {1}}}{{\\partial {2}}}", { i(1, "y"), i(2, "x") })),
      snip("sm", fmta("\\sum_{<>}^{<>} <>", { i(1), i(2), i(3) })),

      -- Do I like these?
      -- postfix("_", { l("{" .. l.POSTFIX_MATCH .. "}^{}") }),
      -- postfix("^", { l("{" .. l.POSTFIX_MATCH .. "}^{}") }),

      -- powers
      snip("2", t("^2")),
      snip("i", t("^{-1}")),

      -- logic and sets
      snip("set", fmt("\\{{{1}\\}}", { i(1, "x") })),
      snip("\\", t("\\setminus")),
      snip("fa", t("\\forall")),
      snip("fin", fmt("\\forall {{{1}}} \\in {{{2}}}", { i(1), i(2) })),
      snip("dne", t("\\notexists")),
      snip("nin", t("\\not\\in")),
      snip("est", fmt("\\exists {1} :", { i(1, "x") })),
      snip("e", t("\\exists")),
      snip("st", t("\\text{ s.t. }")),
      snip("n", t("\\neg")),
      snip("T", t("\\top")),
      snip("F", t("\\bot")),

      snip("nd", t("\\land")),
      snip("or", t("\\lor")),

      -- Sequents
      snip("en", t("\\vDash")),
      snip("dr", t("\\vdash")),
      snip("dn", t("\\vdash_{ND}")),
      snip("ds", t("\\vdash_{ND}")),

      snip("un", t("\\cup")),
      snip("is", t("\\cap")),

      snip("im", t("\\implies")),
      snip("if", t("\\iff")),
      snip("aim", t("&\\implies")),
      snip("aif", t("&\\iff")),
      snip("ae", t("&=")),
      snip("at", fmta("&\\text{<>}", { i(1) })),

      -- common sets
      snip("mt", t("\\emptyset")),
      snip("bb", fmt("\\mathbb{{{1}}}", { i(1) })),
      snip("R", t("\\mathbb{R}")),
      snip("Rn", fmt("\\mathbb{{R}}^{{{1}}}", { i(1, "n") })),
      snip("Rp", fmt("\\mathbb{{R}}_{{{1}}}", { i(1, "+") })),
      snip("Rnp", fmt("\\mathbb{{R}}^{{{1}}}_{{{2}}}", { i(1, "n"), i(2, "+") })),
      snip("N", t("\\mathbb{N}")),
      snip("Nn", fmt("\\mathbb{{N}}^{{{1}}}", { i(1, "n") })),
      snip("Z", t("\\mathbb{Z}")),
      snip("Zn", fmt("\\mathbb{{Z}}^{{{1}}}", { i(1, "n") })),
      snip("Q", t("\\mathbb{Q}")),
      snip("Qn", fmt("\\mathbb{{Q}}^{{{1}}}", { i(1, "n") })),
      snip("C", t("\\mathbb{C}")),
      snip("Cn", fmt("\\mathbb{{C}}^{{{1}}}", { i(1, "n") })),

      -- vectors
      snip("0", t("\\mathbf{0}")),
      snip("bf", fmt("\\mathbf{{{1}}}", { i(1) })),
      snip("cv", fmt("{1} {2} + (1-{1}) {3}", { i(1, "\\alpha"), i(2, "x"), i(3, "y") })),
      snip("x", t("\\mathbf{x}")),
      snip("y", t("\\mathbf{y}")),
      snip("b", t("\\mathbf{b}")),

      --- other letters
      snip("bb", fmt("\\mathbb{{{1}}}", { i(1) })),
      snip("mc", fmt("\\mathcal{{{1}}}", { i(1) })),
      snip("L", t("\\mathcal{L}")),
      snip("F", t("\\mathcal{F}")),
      snip("P", t("\\mathbb{P}")),
      snip("W", t("\\mathcal{W}")),
      snip("B", t("\\mathcal{B}")),
      snip( -- FIX: can't get this to work with fmt()
        "Px",
        { t("\\mathbb{P}_"), i(1, "i"), t(" (x_"), rep(1), t(")") }
      ),

      -- preferences
      snip("pf", t("\\succsim")),
      snip("npf", t("\\precsim")),
      snip("PF", t("\\succ")),
      snip("NPF", t("\\prec")),

      -- extrema
      snip("sp", fmt("\\sup({1})", { i(1, "A") })),
      snip("in", fmt("\\inf({1})", { i(1, "A") })),

      -- LaTeX template
      snip(
        "tmp",
        fmta(
          [[

      \documentclass[a4paper]{article}

      \usepackage{fullpage}
      %\usepackage{geometry}
      %\usepackage{titling}

      \usepackage{amsmath}
      \usepackage{amssymb}

      \usepackage[style=authoryear,natbib=true,isbn=false,url=false,eprint=false]{biblatex} %style=apa
      \usepackage{hyperref}

      %\usepackage{graphicx}
      %\usepackage[font={small,sf}]{caption}
      %\usepackage{float}
      %\usepackage{booktabs}
      %\usepackage{pgfplots}

      \title{<>}
      \author{<>}
      \date{<>}

      \addbibresource{~/Documents/zotero/bib.bib}

      \begin{document}

      \maketitle

      <>

      %\printbibliography

      \end{document}
      ]],
          { i(1), i(2, "Liam van der Vyver"), i(3), i(4) }
        )
      ),

      -- these assume brackets get autocompleted
      snip("l(", fmta("\\left( <> \\right", { i(1, "") })),
      snip("l[", fmta("\\left[ <> \\right", { i(1, "") })),
      snip("l{", fmta("\\left\\{ <> \\right\\", { i(1, "") })),

      -- optimisation
      snip(
        "lg",
        fmta(
          "\\mathcal{L}(<>) = <> - \\lambda \\left( <> \\right)",
          { i(1, "\\mathbf{x}, \\lambda"), i(2, "f(\\mathbf{x})"), i(3, "g(\\mathbf{x}) - b") }
        )
      ),
    },

    markdown = {

      -- yaml headers
      snip(
        "lit",
        fmt(
          [[
        ---
        tags: literature
        source: {1}
        ---

        {2}
        ]],
          { i(1), i(2) }
        )
      ),

      snip(
        "per",
        fmt(
          [[
        ---
        tags: permanent
        ---

        {1}
        ]],
          { i(1) }
        )
      ),

      snip(
        "fle",
        fmt(
          [[
        ---
        tags: fleeting
        ---

        {1}
        ]],
          { i(1) }
        )
      ),

      -- Maths notes
      snip("pf", t("**Proof**: ")),
      snip("pr", t("**Proposition**: ")),
      snip("tm", t("**Theorem**: ")),
      snip("cl", t("**Corrolary**: ")),
      snip("df", t("**Definition**: ")),
    },

    c = {

      snip(
        "mv",
        fmta(
          [[
        int main(void)
        {
            <1>
        }
        ]],
          { i(1) }
        )
      ),

      snip(
        "ma",
        fmta(
          [[
        int main(int argc, char *argv[]) {
            <1>
        }
        ]],
          { i(1) }
        )
      ),

      snip(
        "fo",
        fmta(
          [[
        for (<1>; <2>; <3>) {
            <4>
        }
        ]],
          { i(1, "int i = 0"), i(2, "i < n"), i(3, "i++"), i(4) }
        )
      ),

      snip(
        "dw",
        fmta(
          [[
        do {
            <2>
        } while (<1>)
        ]],
          { i(1), i(2) }
        )
      ),

      snip(
        "wh",
        fmta(
          [[
        while (<1>) {
            <2>
        }
        ]],
          { i(1), i(2) }
        )
      ),

      snip("pt", fmt([[{1} *{2} = malloc({3} * sizeof({4}))]], { i(1), i(2), i(3), rep(1) })),
    },

    javascript = {
      snip("fn", fmta([[<1> = (<2>) =>> {<3>};]], { i(1), i(2), i(3) })),
      snip("ar", fmta([[(<1>) =>> {<2>};]], { i(1), i(2) })),
    },
  })
end

return M
