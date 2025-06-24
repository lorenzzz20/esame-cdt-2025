<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei">

  <xsl:output method="html" doctype-system="about:legacy-compat" indent="yes"/>

  <!-- Root template -->
  <xsl:template match="/">
    <html lang="it">
      <head>
        <meta charset="UTF-8"/>
        <title>
          <xsl:value-of select="//tei:teiHeader//tei:titleStmt/tei:title"/>
        </title>
        <link rel="stylesheet" href="styles.css"/>
      </head>
      <body>
       <!-- TEI Header + Navbar -->
        <section id="metadata">
          <header>
            <h1>CODIFICA DI TESTI</h1>

            <!-- Navbar integrata -->
            <nav id="main-nav">
              <ul>
                <li><a href="#metadata">Metadati</a></li>
                <li><a href="#facsimile">Facsimile</a></li>
                <li><a href="#content">Contenuto</a></li>
                <li><a href="#glossary">Glossario</a></li>
              </ul>
            </nav>
          </header>

          <!-- Contenuti TEI Header -->
          <xsl:apply-templates select="//tei:teiHeader"/>
        </section>

        <!-- Pulsanti di filtro -->
        <div id="buttons">
          <h3>Filtra per entità</h3>
          <button data-class="persName" data-highlight-class="highlight-person">Nomi di persona</button>
          <button data-class="placeName" data-highlight-class="highlight-place">Nomi di luogo</button>
          <button data-class="orgName" data-highlight-class="highlight-org">Nomi di organizzazioni</button>
          <button data-class="title" data-highlight-class="highlight-title">Titoli</button>
          <button data-class="addName" data-highlight-class="highlight-addName">Epiteti (addName)</button>
          <button data-class="roleName" data-highlight-class="highlight-roleName">Ruoli (roleName)</button>
          <button data-class="name" data-highlight-class="highlight-name">Nomi (name)</button>
          <button data-class="foreign" data-highlight-class="highlight-foreign">Parole straniere</button>

          <h3>Azioni</h3>
          <button id="switch-choice">Mostra versione corretta</button>
          <button data-class="quote" data-highlight-class="highlight-quote">Citazioni</button>
          <button data-class="hi" data-highlight-class="highlight-hi">Corsivo (hi)</button>
          <button data-class="note" data-highlight-class="highlight-note">Note</button>
          <button data-class="date" data-highlight-class="highlight-date">Date</button>
          <button id="highlight-all">Evidenzia Tutto</button>
          <button data-class="reset-filters" class="btn-reset">Reimposta filtri</button>

          <h3>Filtra per tipo di termine</h3>
          <button data-class="term" data-type="theme" data-highlight-class="highlight-theme">Termini (Theme)</button>
          <button data-class="term" data-type="legal" data-highlight-class="highlight-legal">Termini (Legal)</button>
          <button data-class="term" data-type="moral" data-highlight-class="highlight-moral">Termini (Moral)</button>
          <button data-class="term" data-type="economic" data-highlight-class="highlight-economic">Termini (Economic)</button>
          <button data-class="term" data-type="nonStandard" data-highlight-class="highlight-nonStandard">Termini (Non Standard)</button>
          <button data-class="term" data-type="textual" data-highlight-class="highlight-textual">Termini (Textual)</button>
          <button data-class="term" data-type="social" data-highlight-class="highlight-social">Termini (Social)</button>
          <button data-class="term" data-type="infrastructure" data-highlight-class="highlight-infrastructure">Termini (Infrastructure)</button>
          <button data-class="term" data-type="literaryMovement" data-highlight-class="highlight-literaryMovement">Movimenti Letterari</button>
        </div>

        <!-- Facsimile -->
        <section id="facsimile">
          <h2>Facsimili</h2>
          <xsl:apply-templates select="//tei:facsimile"/>
        </section>

        <!-- Testo principale -->
        <section id="content">
          <h2>Contenuto</h2>
          <xsl:apply-templates select="//tei:text"/>
        </section>

        <!-- Glossario (standOff) -->
        <section id="glossary">
          <xsl:apply-templates select="//tei:standOff"/>
        </section>
      </body>
      <script src="scripts.js"></script>
    </html>
  </xsl:template>

  <!-- TEI Header -->
  <xsl:template match="tei:teiHeader">
    <div class="teiHeader">
      <section class="teiHeader-title">
        <h2 class="title">
          <xsl:value-of select="tei:fileDesc/tei:titleStmt/tei:title"/>
        </h2>
        <p class="author"><strong>Autore:</strong> <xsl:value-of select="tei:fileDesc/tei:titleStmt/tei:author"/></p>

        <xsl:for-each select="tei:fileDesc/tei:titleStmt/tei:respStmt">
          <div class="respStmt">
            <span class="resp-label"><strong><xsl:value-of select="tei:resp"/>:</strong></span>
            <span class="resp-names">
              <xsl:for-each select="tei:name">
                <span id="{@xml:id}" class="name"><xsl:value-of select="."/></span>
                <xsl:if test="position() != last()">, </xsl:if>
              </xsl:for-each>
            </span>
          </div>
        </xsl:for-each>
      </section>
    </div>

      <!-- Sezione Metadati Editoriali -->
      <div class="teiHeader-metadata">
        <!-- Edizione -->
        <section class="teiHeader-edition">
          <h3>Edizione</h3>
          <p class="edition"><xsl:value-of select="tei:fileDesc/tei:editionStmt/tei:edition"/></p>
          <xsl:for-each select="tei:fileDesc/tei:editionStmt/tei:respStmt">
            <div class="respStmt">
              <span class="resp-label"><strong><xsl:value-of select="tei:resp"/>:</strong></span>
              <span class="resp-names">
                <xsl:for-each select="tei:name">
                  <span class="name"><xsl:value-of select="."/></span>
                  <xsl:if test="position() != last()">, </xsl:if>
                </xsl:for-each>
              </span>
            </div>
          </xsl:for-each>
        </section>

        <!-- Pubblicazione -->
        <section class="teiHeader-publication">
          <h3>Pubblicazione</h3>
          <p><strong>Editore:</strong> <xsl:value-of select="tei:fileDesc/tei:publicationStmt/tei:publisher"/></p>
          <p><strong>Luogo:</strong> <xsl:value-of select="tei:fileDesc/tei:publicationStmt/tei:pubPlace"/></p>
          <p>
            <strong>Data:</strong>
            <xsl:variable name="date" select="tei:fileDesc/tei:publicationStmt/tei:date"/>
            <span>
              <xsl:if test="$date/@from">
                (<xsl:value-of select="$date/@from"/>–<xsl:value-of select="$date/@to"/>) 
              </xsl:if>
              <xsl:value-of select="$date"/>
            </span>
          </p>
        </section>

        <!-- Corso e Docente -->
        <section class="teiHeader-course">
          <h3>Corso e Docente</h3>
          <xsl:for-each select="tei:fileDesc/tei:seriesStmt">
            <p><strong>Corso:</strong> <xsl:value-of select="tei:title"/></p>
            <xsl:for-each select="tei:respStmt">
              <div class="respStmt">
                <span class="resp-label"><strong><xsl:value-of select="tei:resp"/>:</strong></span>
                <span class="resp-names">
                  <xsl:for-each select="tei:persName">
                    <xsl:value-of select="."/>
                    <xsl:if test="position() != last()">, </xsl:if>
                  </xsl:for-each>
                </span>
              </div>
            </xsl:for-each>
          </xsl:for-each>
        </section>

        <!-- Note Editoriali -->
        <section class="teiHeader-notes">
          <h3>Note Editoriali</h3>
          <xsl:for-each select="tei:fileDesc/tei:notesStmt/tei:note">
            <div class="note-item">
              <strong>Nota</strong> 
              <xsl:if test="@type">(<xsl:value-of select="@type"/>)</xsl:if>:
              <span class="note-text"><xsl:value-of select="."/></span>
            </div>
          </xsl:for-each>
        </section>
      </div>

      <!-- Bibliografia degli articoli -->
      <div class="teiHeader-bibliography">
        <h3>Bibliografia degli articoli</h3>
        
        <div class="bibl-row first-row">
          <xsl:for-each select="tei:fileDesc/tei:sourceDesc/tei:listBibl/tei:bibl[position() &lt;= 3]">
            <div id="{@xml:id}" class="bibl-item">
              <strong class="bibl-title"><xsl:value-of select="tei:title"/></strong>
              <span class="bibl-author"><xsl:value-of select="tei:author"/></span>
              <span class="bibl-pubplace"><xsl:value-of select="tei:pubPlace"/></span>
              <span class="bibl-publisher"><xsl:value-of select="tei:publisher"/></span>
              <span class="bibl-date"><xsl:value-of select="tei:date"/></span>
              <xsl:if test="tei:biblScope">
                <div class="bibl-scope">
                  <xsl:for-each select="tei:biblScope">
                    <span><strong><xsl:value-of select="@unit"/>:</strong> 
                    <xsl:choose>
                      <xsl:when test="@from and @to">
                        <xsl:value-of select="@from"/>–<xsl:value-of select="@to"/>
                      </xsl:when>
                      <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
                    </xsl:choose>
                    </span>
                  </xsl:for-each>
                </div>
              </xsl:if>
              <xsl:if test="tei:note">
                <div class="bibl-note"><em><xsl:value-of select="tei:note"/></em></div>
              </xsl:if>
            </div>
          </xsl:for-each>
        </div>

        <div class="bibl-row second-row">
          <xsl:for-each select="tei:fileDesc/tei:sourceDesc/tei:listBibl/tei:bibl[position() &gt; 3]">
            <div id="{@xml:id}" class="bibl-item">
              <strong class="bibl-title"><xsl:value-of select="tei:title"/></strong>
              <span class="bibl-author"><xsl:value-of select="tei:author"/></span>
              <span class="bibl-pubplace"><xsl:value-of select="tei:pubPlace"/></span>
              <span class="bibl-publisher"><xsl:value-of select="tei:publisher"/></span>
              <span class="bibl-date"><xsl:value-of select="tei:date"/></span>
              <xsl:if test="tei:biblScope">
                <div class="bibl-scope">
                  <xsl:for-each select="tei:biblScope">
                    <span><strong><xsl:value-of select="@unit"/>:</strong> 
                      <xsl:choose>
                        <xsl:when test="@from and @to">
                          <xsl:value-of select="@from"/>–<xsl:value-of select="@to"/>
                        </xsl:when>
                        <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
                      </xsl:choose>
                    </span>
                  </xsl:for-each>
                </div>
              </xsl:if>
              <xsl:if test="tei:note">
                <div class="bibl-note"><em><xsl:value-of select="tei:note"/></em></div>
              </xsl:if>
            </div>
          </xsl:for-each>
        </div>
      </div>

      <!-- Progetto e Linee Editoriali -->
      <div class="teiHeader-project">
        <h3>Progetto e Linee Editoriali</h3>
        <div class="projectDesc">
          <h4>Descrizione del progetto</h4>
          <p><xsl:value-of select="tei:encodingDesc/tei:projectDesc/tei:p"/></p>

          <h4>Linee editoriali</h4>
          <p><xsl:value-of select="tei:encodingDesc/tei:editorialDecl/tei:p"/></p>

          <h4>Campione</h4>
          <p><xsl:value-of select="tei:encodingDesc/tei:samplingDecl/tei:p"/></p>
        </div>
      </div>

      <!-- Lingue presenti nel testo -->
      <div class="teiHeader-languages">
        <h3>Lingue presenti nel testo</h3>
        <ul>
          <xsl:for-each select="tei:profileDesc/tei:langUsage/tei:language">
            <li><span class="lang" data-ident="{@ident}"><xsl:value-of select="."/></span></li>
          </xsl:for-each>
        </ul>
      </div>
  </xsl:template>

  <!-- Template placeholder: facsimile -->
  <xsl:template match="tei:facsimile">
    <div class="facsimile-grid">
      <xsl:for-each select="tei:surface">
        <figure class="facsimile-item">
          <img src="{tei:graphic/@url}" alt="Facsimile di {@xml:id}" onclick="openLightbox(this.src)" />
          <figcaption><xsl:value-of select="@xml:id"/></figcaption>
        </figure>
      </xsl:for-each>
    </div>

    <!-- Lightbox overlay -->
    <div id="lightbox-overlay" onclick="closeLightbox()">
      <img id="lightbox-image" src="" alt="Facsimile ingrandito"/>
    </div>
  </xsl:template>

    <!-- Template per ciascun div principale (articolo) -->
    <xsl:template match="tei:div">
      <div id="{@xml:id}" class="tei-div tei-article">
        <xsl:if test=".//tei:head">
          <h2 class="tei-article-title">
            <xsl:value-of select=".//tei:head[1]"/>
          </h2>
        </xsl:if>
        <div class="tei-article-content">
          <xsl:apply-templates/>
        </div>
      </div>
    </xsl:template>

    <!-- PARAGRAFI: trasforma in <p> e gestisce facs e xml:id -->
    <xsl:template match="tei:p">
      <p data-facs="{@facs}">
        <xsl:apply-templates/>
      </p>
    </xsl:template>

    <!-- TERM con ORIG/REG all'interno -->
    <xsl:template match="tei:term[tei:orig or tei:reg]">
      <span class="term" data-type="{@type}">
        <xsl:if test="tei:orig">
          <span class="orig-sic"><xsl:apply-templates select="tei:orig"/></span>
        </xsl:if>
        <xsl:if test="tei:reg">
          <span class="corr-reg"><xsl:apply-templates select="tei:reg"/></span>
        </xsl:if>
      </span>
    </xsl:template>

    <!-- TERM GENERICO (fall-back) -->
    <xsl:template match="tei:term">
      <span class="term" data-type="{@type}">
        <xsl:apply-templates/>
      </span>
    </xsl:template>

    <!-- LISTE DI KEYWORDS NEL TESTO -->
    <xsl:template match="tei:list[@type='keywords']">
      <div class="keywords">
        <h3>Parole chiave</h3>
        <ul>
          <xsl:for-each select="tei:item">
            <li class="keyword-item">
              <span class="keyword"><xsl:apply-templates select="tei:term"/></span>
            </li>
          </xsl:for-each>
        </ul>
      </div>
    </xsl:template>

    <!-- CHOICE -->
    <xsl:template match="tei:choice">
      <span class="choice">
        <xsl:if test="tei:orig or tei:sic">
          <span class="orig-sic"><xsl:apply-templates select="tei:orig|tei:sic"/></span>
        </xsl:if>
        <xsl:if test="tei:corr or tei:reg">
          <span class="corr-reg"><xsl:apply-templates select="tei:corr|tei:reg"/></span>
        </xsl:if>
      </span>
    </xsl:template>

    <!-- VARIANTI TESTUALI -->
    <xsl:template match="tei:orig">
      <span class="orig"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="tei:reg">
      <span class="reg"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="tei:sic">
      <span class="sic"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="tei:corr">
      <span class="corr"><xsl:apply-templates/></span>
    </xsl:template>

    <!-- ENTITÀ NOMINATE -->
    <xsl:template match="tei:persName">
      <span class="persName" data-ref="{@ref}" data-type="{@type}">
        <xsl:apply-templates/>
      </span>
    </xsl:template>

    <xsl:template match="tei:placeName">
      <span class="placeName" data-ref="{@ref}" data-type="{@type}">
        <xsl:apply-templates/>
      </span>
    </xsl:template>

    <xsl:template match="tei:orgName">
      <span class="orgName" data-ref="{@ref}" data-type="{@type}">
        <xsl:apply-templates/>
      </span>
    </xsl:template>

    <xsl:template match="tei:addName">
      <span class="addName"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="tei:roleName">
      <span class="roleName" data-type="{@type}"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="tei:name">
      <span class="name" data-type="{@type}"><xsl:apply-templates/></span>
    </xsl:template>

    <!-- TESTI BIBLIOGRAFICI -->
    <xsl:template match="tei:title">
      <xsl:choose>
        <xsl:when test="@type='work'">
          <cite class="title" data-ref="{@ref}" data-type="{@type}">
            <xsl:apply-templates/>
          </cite>
        </xsl:when>
        <xsl:otherwise>
          <span class="title" data-ref="{@ref}" data-type="{@type}">
            <xsl:apply-templates/>
          </span>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>

    <!-- DATE, NOTE e CORSIVO -->
    <xsl:template match="tei:date">
      <time class="date" datetime="{@when}" data-from="{@from}" data-to="{@to}">
        <xsl:apply-templates/>
      </time>
    </xsl:template>

    <xsl:template match="tei:note">
      <span class="note" data-type="{@type}" id="{@xml:id}">
        <xsl:apply-templates/>
      </span>
    </xsl:template>

    <xsl:template match="tei:hi">
      <span class="hi" data-rend="{@rend}"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="tei:quote">
      <span class="quote"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="tei:foreign">
      <span class="foreign" lang="{@xml:lang}"><xsl:apply-templates/></span>
    </xsl:template>

    <!-- StandOff: trasforma listPerson, listPlace e listBibl in sezioni HTML leggibili e semantiche -->
    <xsl:template match="tei:standOff">
      <div class="standoff">
        <h3>Glossario</h3>
        <div class="standoff-grid">
          <xsl:if test="tei:listPerson">
            <div class="standoff-grid-item">
              <h4>Persone</h4>
              <ul>
                <xsl:for-each select="tei:listPerson/tei:person">
                  <li id="{@xml:id}" class="person-item">
                    <span class="person-name"><xsl:value-of select="tei:persName"/></span>
                    <xsl:if test="tei:note">
                      <span class="note"> — <xsl:value-of select="tei:note"/></span>
                    </xsl:if>
                  </li>
                </xsl:for-each>
              </ul>
            </div>
          </xsl:if>

          <xsl:if test="tei:listPlace">
            <div class="standoff-grid-item">
              <h4>Luoghi</h4>
              <ul>
                <xsl:for-each select="tei:listPlace/tei:place">
                  <li id="{@xml:id}" class="place-item">
                    <span class="place-name"><xsl:value-of select="tei:placeName"/></span>
                    <xsl:if test="tei:note">
                      <span class="note"> — <xsl:value-of select="tei:note"/></span>
                    </xsl:if>
                  </li>
                </xsl:for-each>
              </ul>
            </div>
          </xsl:if>

          <xsl:if test="tei:listBibl">
            <div class="standoff-grid-item">
              <h4>Bibliografia</h4>
              <ul>
              <xsl:for-each select="tei:listBibl/tei:bibl">
                <li id="{@xml:id}" class="bibl-item">
                  <span class="bibl-title"><xsl:value-of select="tei:title"/></span>
                  <xsl:if test="tei:author">
                    <span class="bibl-author">, <strong>Autore:</strong> <xsl:value-of select="tei:author"/></span>
                  </xsl:if>
                  <xsl:if test="tei:pubPlace">
                    <span class="bibl-place">, <strong>Luogo:</strong> <xsl:value-of select="tei:pubPlace"/></span>
                  </xsl:if>
                  <xsl:if test="tei:date">
                    <span class="bibl-date">, <strong>Data:</strong> <xsl:value-of select="tei:date"/></span>
                  </xsl:if>
                </li>
              </xsl:for-each>
              </ul>
            </div>
          </xsl:if>

          <xsl:if test="tei:list[@xml:id='listMovimentiLetterari']">
            <div class="standoff-grid-item">
              <h4>Movimenti Letterari</h4>
              <ul>
                <xsl:for-each select="tei:list[@xml:id='listMovimentiLetterari']/tei:item">
                  <li id="{@xml:id}" class="movement-item">
                    <span class="movement-name">
                      <xsl:value-of select="tei:term"/>
                    </span>
                    <xsl:if test="tei:desc">
                      <div class="movement-desc">
                        <xsl:value-of select="tei:desc"/>
                      </div>
                    </xsl:if>
                    <xsl:if test="tei:note">
                      <div class="movement-note">
                        <xsl:value-of select="tei:note"/>
                      </div>
                    </xsl:if>
                  </li>
                </xsl:for-each>
              </ul>
            </div>
          </xsl:if>
        </div>
      </div>
    </xsl:template>
</xsl:stylesheet>
