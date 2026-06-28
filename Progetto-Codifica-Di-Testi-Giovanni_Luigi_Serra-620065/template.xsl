<?xml version="1.0" encoding="UTF-8"?> <!--è il tag radice che indica la versione di xml e l'encoding(formato testo) del testo, in questo caso utf8 -->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei">
<!-- da riga 2 a riga 5: riga2 = indica che è un foglio di stile xsl e la versione 1
 riga3= xmlns vuol dire xml NAMESPACE,:xsl è il prefisso del documento e dice che ogni elemento col prefiso xsl appartiene al linguaggio xslt
 l'url significa "questi elementi appartengono a quel linguaggio preciso
 riga4: stiamo introducendo il prefisso "tei" e dicendo che TUTTI GLI ELEMENTI CON QUEL PREFISSO
  APPARTENGONO AL VOCABOLARIO TEI VERSIONE 1.0
  riga5= sto dicendo di non includere nel documento finale il namespace TEI (cioè xmlns:tei="..."), altrimenti vedrei nelle dichiarazioni dei tag la presenza del xmlns:tei ecc
   Cos'è un namespace? Un identificatore univoco da dare ai nomi ed elementi del file, che specifica
   a quale vocabolario appartiene, per non farlo confondere con tag uguali ma di altri linguaggi-->
  <xsl:output method="html" encoding="UTF-8" indent="yes"
              doctype-public="-//W3C//DTD HTML 4.01//EN"/>
<!-- riga 14/15 = l'output deve essere HTML, con quel encoding, indentato, e deve seguire quello standard html, in lingua EN, che è la lingua generalmente accettata dai browser-->
  <!-- potrei mettere come output ancge xml, xhtml, text!-->
    <!--  RADICE  -->
  <xsl:template match="/"> <!--trasformo (template) alla radice "/" il file -->
    <html lang="it">
      <head>
        <meta charset="UTF-8"/> <!--Definisce la codifica dei caratteri della pagina HTML,serve perché l’output XSLT potrebbe contenere caratteri speciali (è, à, ò, ecc.) -->
        <title>Progetto di Codifica - del Grosso/Serra</title> <!-- Title che appare-->
        <link rel="stylesheet" type="text/css" href="stile.css"/> <!--richiamo al foglio di stile -->
      </head>
      <body>

          <!-- ora definisco le sezioni della pagine come le ho in mente per il progetto -->
        <!-- BANNER -->
        <div class="banner">
          <h1>La rassegna settimanale</h1>
          <p>A cura di Angelo Mario del Grosso e Giovanni Luigi Serra</p>
          <p>Le opere trattate sono
            <em>"Un Segreto"</em> e
            <em>"L'essere troppo stimati"</em>
          </p>
            <!--un semplice anchor agli id dei div che riportano ai testi -->
          <nav id="opere-ancoraggio">
            <ul>
              <li><a href="#storia_un_segreto">Un segreto</a></li>
              <li><a href="#articolo_essere_troppo_stimati">L'essere troppo stimati</a></li>
              <li><a href="#sezione_notizie">Notizie</a></li>
              <li><a href="#sezione_bibliografia">Bibliografia</a></li>
            </ul>
          </nav>
        </div>

          <!-- fondamentale per fornire una guida all'utente che volesse evidenziare solo certi aspetti del testo;
          è importante sottolineare come le CLASSI DEL CODICE facciano riferimento al titolo della categoria, e gli ID alle
          categorie specifiche a cui una parola appartiene, parte in pagina (non js)-->
        <!--TOOLBAR EVIDENZIAZIONE-->
          <div id="toolbar-highlight">
              <span class="toolbar-label">Evidenzia nel testo:</span>

              <div class="toolbar-gruppo">
                  <button class="highlight-btn" data-tipo="persName">👤 Persone</button>
                  <select class="highlight-select" data-tipo="persName">
                      <option value="">— sottocategoria —</option>
                      <option value="#persName.reale">Reale</option>
                      <option value="#persName.fittizia">Fittizia</option>
                      <option value="#persName.storico">Storica</option>
                      <option value="#persName.generico">Generica</option>
                  </select>
              </div>

              <div class="toolbar-gruppo">
                  <button class="highlight-btn" data-tipo="placeName">📍 Luoghi</button>
                  <select class="highlight-select" data-tipo="placeName">
                      <option value="">— sottocategoria —</option>
                      <option value="#placeName.citta">Città</option>
                      <option value="#placeName.urbano">Urbano</option>
                      <option value="#placeName.via">Via/Vicolo</option>
                      <option value="#placeName.natura">Natura</option>
                      <option value="#placeName.montagna">Montagna</option>
                      <option value="#placeName.territorio">Territorio</option>
                      <option value="#placeName.regione">Regione</option>
                      <option value="#placeName.nazione">Nazione</option>
                      <option value="#placeName.storico">Storico</option>
                  </select>
              </div>

              <div class="toolbar-gruppo">
                  <button class="highlight-btn" data-tipo="orgName">🏛️ Organizzazioni</button>
                  <select class="highlight-select" data-tipo="orgName">
                      <option value="">— sottocategoria —</option>
                      <option value="#orgName.istituzione">Istituzione</option>
                      <option value="#orgName.editore">Editore</option>
                      <option value="#orgName.giornale">Giornale</option>
                      <option value="#orgName.tipografia">Tipografia</option>
                      <option value="#orgName.accademia">Accademia</option>
                      <option value="#orgName.militare">Militare</option>
                  </select>
              </div>

              <div class="toolbar-gruppo">
                  <button class="highlight-btn" data-tipo="term">📚 Termini</button>
                  <select class="highlight-select" data-tipo="term">
                      <option value="">— sottocategoria —</option>
                      <option value="#term.genere">Genere</option>
                      <option value="#term.volume">Volume</option>
                      <option value="#term.numero">Numero</option>
                      <option value="#term.etnia">Etnia</option>
                      <option value="#term.animale">Animale</option>
                      <option value="#term.cibo">Cibo</option>
                      <option value="#term.ruolo">Ruolo</option>
                      <option value="#term.caratteristica">Caratteristica</option>
                  </select>
              </div>

              <div class="toolbar-gruppo">
                  <button class="highlight-btn" data-tipo="term">⚖️ Morale</button>
                  <select class="highlight-select" data-tipo="term">
                      <option value="">— sottocategoria —</option>
                      <option value="#moral.positivo">Positivo</option>
                      <option value="#moral.negativo">Negativo</option>
                  </select>
              </div>

              <div class="toolbar-gruppo">
                  <button class="highlight-btn" data-tipo="term">🎭 Classe Sociale</button>
                  <select class="highlight-select" data-tipo="term">
                      <option value="">— sottocategoria —</option>
                      <option value="#socialclass.nobilta">Nobiltà</option>
                      <option value="#socialclass.borghesia">Borghesia</option>
                      <option value="#socialclass.indigente">Indigente</option>
                      <option value="#socialclass.militare">Militare (status)</option>
                  </select>
              </div>

              <div class="toolbar-gruppo">
                  <button class="highlight-btn" data-tipo="measure">📏 Misure</button>
                  <select class="highlight-select" data-tipo="measure">
                      <option value="">— sottocategoria —</option>
                      <option value="#measure.ricchezza">Ricchezza</option>
                      <option value="#measure.tempo">Tempo</option>
                      <option value="#measure.durata">Durata</option>
                      <option value="#measure.eta">Età</option>
                  </select>
              </div>

              <div class="toolbar-gruppo">
                  <button class="highlight-btn" data-tipo="term">🔤 Lingua</button>
                  <select class="highlight-select" data-tipo="term">
                      <option value="">— sottocategoria —</option>
                      <option value="#ling_regionali">Regionale</option>
                      <option value="#ling_storiche">Storica</option>
                  </select>
              </div>

              <div class="toolbar-gruppo">
                  <button class="highlight-btn" data-tipo="title">📖 Titoli</button>
                  <select class="highlight-select" data-tipo="title">
                      <option value="">— sottocategoria —</option>
                      <option value="#title.principale">Principale</option>
                      <option value="#title.secondario">Secondario</option>
                      <option value="#title.tradotto">Tradotto</option>
                  </select>
              </div>

              <div class="toolbar-gruppo">
                  <button class="highlight-btn" data-tipo="date">📅 Date</button>
                  <select class="highlight-select" data-tipo="date">
                      <option value="">— sottocategoria —</option>
                      <option value="#date.anno">Anno</option>
                  </select>
              </div>
          </div>

        <!--SCHEDA INFORMAZIONI, il motore che decide cosa appare in HTML e come -->
        <xsl:call-template name="scheda-informazioni"/> <!--sto richiamando il template-name "scheda-informazioni" (riga 222-366), che nel nostro caso
         conterrà le informazioni di interesse inserite nel file XML, in questo caso le informazioni preliminari dell'opera:
         TESTATA, FONDATORI,EDITORI,ESEMPLARE,STORIA, tag del footer-->
        <!--FRONTESPIZIO-->
          <!--di fatto applicazione del template andando a cercare nei NODI del documento XML:
          1) vai del documento XML
          2) trova nodo <front> che è dentro <text>(come le directory)
          3)cerca e applica il foglio di stile "match=tei:front"
          riga 380_450-->
        <xsl:apply-templates select="//tei:text/tei:front"/>

        <!-- ARTICOLI -->
          <!-- vai nel file xml, cerca body e applica il template di nome tei:body, riga 412-421
          questo perchè gli articoli sono nel body del file xml.-->
        <xsl:apply-templates select="//tei:body"/>

        <!-- APPENDICE (back) -->
          <!-- idem, riga 690-713, qui abbiamo inserito il glossario dei termini e i personaggi-->
        <xsl:apply-templates select="//tei:back"/>

        <!-- Overlay per zoom facsimile -->
        <div class="facsimile-overlay" id="facsimile-overlay"/>

        <script src="script.js"></script>
        
      </body>
    </html>
  </xsl:template>


  <!-- SCHEDA INFORMAZIONI (teiHeader) -->
  <xsl:template name="scheda-informazioni">
    <div id="informazioni-rassegna">

      <!-- TESTATA -->
      <div class="scheda-card">
        <p class="scheda-label">Testata</p>
        <p class="scheda-titolo-principale" id="titolo-principale"> <!--stiamo dando tag html -->
          <xsl:value-of select="//tei:titleStmt/tei:title[@type='opera_principale']"/>
            <!--esempio pratico di selezione tramite visita dei nodi e @type.
             selezioniamo il valore all'interno di: titleStmt-> title(tag tei) -> di @type='nome_assegnato_da_noi'
             !ATTENZIONE! stiamo cercando OVUNQUE nel documento " // "
             RISULTATO: STAMPA NELL'HTML IL TESTO DEL TITOLO PRINCIPALE-->
        </p>
        <p class="scheda-titolo-categoria" id="titolo-categoria">
          <xsl:value-of select="//tei:titleStmt/tei:title[@type='opera_categoria']"/>
        </p>
      </div>

      <!-- FONDATORI + EDITORE -->
      <div class="scheda-grid-2">
        <div class="scheda-card-secondary">
          <p class="scheda-label">Fondatori</p>
            <!--qui abbiamo inserito i due fondatori della rassegna, in ordine sono
            <titleStmt><author>Francesco Martini<author><author>Sydney Sonnino<author></titleStmt>
            però in xsl questa estrazione va resa con l'applicazione di indici posizionali in un array:
            Xpath-->
          <p id="autore-1"><xsl:value-of select="//tei:titleStmt/tei:author[1]"/></p>
          <p id="autore-2"><xsl:value-of select="//tei:titleStmt/tei:author[2]"/></p>
        </div>
        <div class="scheda-card-secondary">
          <p class="scheda-label">Editore</p>
          <p id="publisher">
            <xsl:value-of select="//tei:publicationStmt/tei:publisher/tei:orgName"/>
          </p>
          <p id="pub-luogo">
            <xsl:value-of select="//tei:publicationStmt/tei:pubPlace"/>,
            <xsl:value-of select="//tei:publicationStmt/tei:address/tei:postCode"/> -
            <xsl:value-of select="//tei:publicationStmt/tei:address/tei:name[@type='place']"/>
          </p>
        </div>
      </div>

      <!-- ESEMPLARE -->
      <div class="scheda-card">
        <p class="scheda-label">Esemplare</p>
        <table class="scheda-table">
          <tr>
            <td class="scheda-table-key">Conservato a</td>
            <td id="conservazione">
              <xsl:value-of select="//tei:msIdentifier/tei:settlement"/> —
              <xsl:value-of select="//tei:msIdentifier/tei:repository"/>
            </td>
          </tr>
          <tr>
            <td class="scheda-table-key">Segnatura</td>
            <td id="idno"><xsl:value-of select="//tei:msIdentifier/tei:idno"/></td>
          </tr>
          <tr>
            <td class="scheda-table-key">Volume</td>
            <td id="volume">
              <xsl:value-of select="//tei:msContents/tei:p/tei:bibl/tei:biblScope[@unit='volume']"/>
            </td>
          </tr>
          <tr>
            <td class="scheda-table-key">Numero</td>
            <td id="issue">
              <xsl:value-of select="//tei:msContents/tei:p/tei:bibl/tei:biblScope[@unit='issue']"/>
            </td>
          </tr>
          <tr>
            <td class="scheda-table-key">Data</td>
            <td id="data-pubblicazione">
              <xsl:value-of select="//tei:msContents/tei:p/tei:bibl/tei:date"/>
            </td>
          </tr>
          <tr>
            <td class="scheda-table-key">Supporto</td>
            <td id="supporto">
              <xsl:value-of select="//tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support"/>
            </td>
          </tr>
          <tr>
            <td class="scheda-table-key">Layout</td>
            <td id="layout">
              <xsl:value-of select="//tei:physDesc/tei:layoutDesc/tei:layout"/>
            </td>
          </tr>
          <tr>
            <td class="scheda-table-key">Tipo</td>
            <td id="tipo">
              <xsl:value-of select="//tei:physDesc/tei:typeDesc/tei:p[1]"/>
            </td>
          </tr>
        </table>
      </div>

      <!-- STORIA -->
      <div class="scheda-card">
        <p class="scheda-label">Storia</p>
        <div class="scheda-timeline">
          <div class="scheda-evento">
            <p class="scheda-evento-data" id="origin-date">
              <xsl:value-of select="//tei:history/tei:origin/tei:date"/>
            </p>
            <p class="scheda-evento-luogo" id="origin-place">
              <xsl:value-of select="//tei:history/tei:origin/tei:placeName"/>
            </p>
            <p class="scheda-evento-testo" id="origin-note">
              <xsl:value-of select="//tei:history/tei:origin/tei:p"/>
            </p>
          </div>
          <div class="scheda-evento">
            <p class="scheda-evento-data" id="prov1-date">
              <xsl:value-of select="//tei:history/tei:provenance[1]/tei:date"/>
            </p>
            <p class="scheda-evento-luogo" id="prov1-place">
              <xsl:value-of select="//tei:history/tei:provenance[1]/tei:placeName"/>
            </p>
            <p class="scheda-evento-testo" id="prov1-note">
              <xsl:value-of select="//tei:history/tei:provenance[1]/tei:p"/>
            </p>
          </div>
          <div class="scheda-evento">
            <p class="scheda-evento-data" id="prov2-date">
              <xsl:value-of select="//tei:history/tei:provenance[2]/tei:date"/>
            </p>
            <p class="scheda-evento-testo" id="prov2-note">
              <xsl:value-of select="//tei:history/tei:provenance[2]/tei:p"/>
            </p>
          </div>
        </div>
      </div>

      <!-- FOOTER DISPONIBILITÀ + LINK -->
      <div class="scheda-footer">
        <p id="disponibilita">
          <xsl:value-of select="//tei:publicationStmt/tei:availability/tei:p"/>
        </p>
        <p id="data-edizione">
          <xsl:value-of select="//tei:publicationStmt/tei:date"/>
        </p>
        <p>
          <a id="link-sito">
            <xsl:attribute name="href">
              <xsl:value-of select="//tei:notesStmt/tei:note/tei:p/tei:ref/@target"/>
            </xsl:attribute>
            Sito ufficiale della Rassegna Settimanale
          </a>
        </p>
      </div>

    </div>
  </xsl:template>


  <!-- FRONT: FRONTESPIZIO -->
  <xsl:template match="tei:front">
    <div id="front">
      <div id="title-page">
        <h1 id="front-titolo">
          <xsl:value-of select="tei:div[@type='titlePage']/tei:head/tei:title"/>
        </h1>
        <p id="front-sottotitolo">
          <xsl:value-of select="tei:div[@type='titlePage']/tei:p[1]"/>
        </p>
        <p id="front-colophon">
          <span id="front-volume">
            <xsl:value-of select="tei:div[@type='titlePage']/tei:p[2]/tei:term[@type='volume']"/>
          </span>,
          <span id="front-luogo">
            <xsl:value-of select="tei:div[@type='titlePage']/tei:p[2]/tei:placeName"/>
          </span>,
          <span id="front-data">
            <xsl:value-of select="tei:div[@type='titlePage']/tei:p[2]/tei:date"/>
          </span>,
          <span id="front-issue">
            <xsl:value-of select="tei:div[@type='titlePage']/tei:p[2]/tei:term[@type='issue']"/>
          </span>
        </p>
      </div>
    </div>
  </xsl:template>


  <!-- BODY: ARTICOLI -->
  <xsl:template match="tei:body">
    <!-- Articolo 1: Un segreto -->
    <xsl:apply-templates select="tei:div[@xml:id='storia_un_segreto']"/>
    <!-- Articolo 2: L'essere troppo stimati -->
    <xsl:apply-templates select="tei:div[@xml:id='articolo_essere_troppo_stimati']"/>
    <!-- Sezione 4: Notizie -->
    <xsl:apply-templates select="tei:div[@xml:id='sezione_notizie']"/>
    <!-- Sezione 5: Bibliografia -->
    <xsl:apply-templates select="tei:div[@xml:id='sezione_bibliografia']"/>
  </xsl:template>


  <!-- ARTICOLO 1: UN SEGRETO -->
  <xsl:template match="tei:div[@xml:id='storia_un_segreto']">
    <div id="storia_un_segreto">
      <div id="un-segreto-head">
        <h2 id="un-segreto-titolo">
          <xsl:value-of select="tei:head/tei:title[@type='main']"/>
        </h2>
      </div>
      <div class="facsimile-layout">
        <div class="facsimile-immagini">
          <p class="facsimile-label">Facsimile</p>
          <img class="facsimile-img" src="img/UNSEGRETO_page-0008.jpg" alt="Un segreto - p. 262"/>
          <img class="facsimile-img" src="img/UNSEGRETO_page-0009.jpg" alt="Un segreto - p. 263"/>
          <img class="facsimile-img" src="img/UNSEGRETO_page-0010.jpg" alt="Un segreto - p. 264"/>
        </div>
        <div class="facsimile-testo" id="un-segreto-body">
          <xsl:apply-templates select="tei:pb | tei:p"/>
        </div>
      </div>
    </div>
  </xsl:template>


  <!-- ARTICOLO 2: L'ESSERE TROPPO STIMATI -->
  <xsl:template match="tei:div[@xml:id='articolo_essere_troppo_stimati']">
    <div id="articolo_essere_troppo_stimati">
      <div id="essere-troppo-stimati-head">
        <h2 id="essere-troppo-stimati-titolo">
          <xsl:value-of select="tei:head/tei:title[@type='main']"/>
        </h2>
      </div>
      <div class="facsimile-layout">
        <div class="facsimile-immagini">
          <p class="facsimile-label">Facsimile</p>
          <img class="facsimile-img" src="img/pag267.jpg" alt="L'essere troppo stimati - p. 267"/>
          <img class="facsimile-img" src="img/pag268.jpg" alt="L'essere troppo stimati - p. 268"/>
        </div>
        <div class="facsimile-testo" id="essere-troppo-stimati-body">
          <xsl:apply-templates select="tei:pb | tei:p"/>
        </div>
      </div>
    </div>
  </xsl:template>


  <!-- Articolo 3 rimosso -->


  <!-- SEZIONE 4: NOTIZIE -->
  <xsl:template match="tei:div[@xml:id='sezione_notizie']">
    <div id="sezione_notizie">
      <div class="sezione-head">
        <h2 class="sezione-titolo">
          <xsl:value-of select="tei:head/tei:title[@type='main']"/>
        </h2>
      </div>
      <div class="facsimile-layout">
        <div class="facsimile-immagini">
          <p class="facsimile-label">Facsimile</p>
          <img class="facsimile-img" src="img/notizie.jpg" alt="Notizie - p. 272"/>
        </div>
        <div class="facsimile-testo notizie-corpo" id="notizie-body">
          <xsl:apply-templates select="tei:div[@type='entry']"/>
        </div>
      </div>
    </div>
  </xsl:template>

  <!-- Singola notizia (div type="entry") -->
  <xsl:template match="tei:div[@type='entry']">
    <div class="notizia">
      <xsl:apply-templates select="tei:p"/>
    </div>
  </xsl:template>


  <!-- SEZIONE 5: BIBLIOGRAFIA-->
  <xsl:template match="tei:div[@xml:id='sezione_bibliografia']">
    <div id="sezione_bibliografia">
      <div class="sezione-head">
        <h2 class="sezione-titolo">
          <xsl:value-of select="tei:head/tei:title[@type='main']"/>
        </h2>
      </div>
      <div class="facsimile-layout">
        <div class="facsimile-immagini">
          <p class="facsimile-label">Facsimile</p>
          <img class="facsimile-img" src="img/notizie.jpg" alt="Bibliografia - p. 272"/>
        </div>
        <div class="facsimile-testo bibliografia-corpo" id="bibliografia-body">
          <!-- bibl, p, pb, cb resi in ordine di documento -->
          <xsl:apply-templates select="tei:pb | tei:cb | tei:bibl | tei:p"/>
        </div>
      </div>
    </div>
  </xsl:template>

  <!-- Voce bibliografica <bibl> -->
  <xsl:template match="tei:bibl">
    <p class="bibl-entry">
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <!-- Autore in voce bibliografica -->
  <xsl:template match="tei:author">
    <span class="bibl-author"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- Indicazione di estensione bibliografica (volume, ecc.) -->
  <xsl:template match="tei:biblScope">
    <span class="biblScope"><xsl:apply-templates/></span>
  </xsl:template>


  <!-- CAMBIO PAGINA <pb> -->
  <xsl:template match="tei:pb">
    <span class="page-break">
      <xsl:attribute name="id">pb_<xsl:value-of select="@n"/></xsl:attribute>
      [p. <xsl:value-of select="@n"/>]
    </span>
  </xsl:template>


  <!-- PARAGRAFI <p> -->
  <xsl:template match="tei:p">
    <xsl:choose>
      <!-- Paragrafo con poesia (lg) dentro -->
      <xsl:when test="tei:lg">
        <div class="inserto-poetico">
          <xsl:attribute name="id">poesia_<xsl:value-of select="@facs"/></xsl:attribute>
          <xsl:apply-templates select="tei:lg"/>
        </div>
      </xsl:when>
      <!-- Paragrafo con closer (firma fonte) -->
      <xsl:when test="tei:seg[@type='closer']">
        <p class="chiusura fonte">
          <xsl:apply-templates/>
        </p>
      </xsl:when>
      <!-- Paragrafo con persName solo (firma autore) -->
      <xsl:when test="tei:persName and not(tei:lb/following-sibling::text()[normalize-space()])">
        <p class="firma">
          <xsl:apply-templates select="tei:persName"/>
        </p>
      </xsl:when>
      <!-- Paragrafo normale -->
      <xsl:otherwise>
        <p class="paragrafo">
          <xsl:if test="@facs and substring-after(@facs,'#') != ''">
            <xsl:attribute name="id"><xsl:value-of select="substring-after(@facs,'#')"/></xsl:attribute>
          </xsl:if>
          <xsl:apply-templates/>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- CITAZIONI POETICHE <quote> con <lg> -->
  <xsl:template match="tei:quote[tei:lg]">
    <div class="inserto-poetico">
      <xsl:apply-templates select="tei:lg"/>
    </div>
  </xsl:template>

  <xsl:template match="tei:lg">
    <div class="strofa">
      <xsl:apply-templates select="tei:l"/>
    </div>
  </xsl:template>

  <xsl:template match="tei:l">
    <p class="verso"><xsl:apply-templates/></p>
  </xsl:template>


  <!-- FIRMA <signed>-->
  <xsl:template match="tei:signed">
    <p class="firma">
      <xsl:apply-templates select="tei:persName"/>
    </p>
  </xsl:template>


  <!-- ELEMENTI INLINE -->

  <!-- Termine con rend italic -->
  <xsl:template match="tei:term[@rend='italic']">
    <em><xsl:apply-templates/></em>
  </xsl:template>

  <!-- Termini -->
  <xsl:template match="tei:term">
    <span class="term">
      <xsl:if test="@ana">
        <xsl:attribute name="data-ana"><xsl:value-of select="@ana"/></xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- Corsivo <hi rend="italic"> -->
  <xsl:template match="tei:hi[@rend='italic']">
    <em><xsl:apply-templates/></em>
  </xsl:template>

  <!-- Nome di persona -->
  <xsl:template match="tei:persName">
    <span class="persName">
      <xsl:if test="@ana">
        <xsl:attribute name="data-ana"><xsl:value-of select="@ana"/></xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- Nome di luogo -->
  <xsl:template match="tei:placeName">
    <span class="placeName">
      <xsl:if test="@ana">
        <xsl:attribute name="data-ana"><xsl:value-of select="@ana"/></xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- Nome di organizzazione -->
  <xsl:template match="tei:orgName">
    <span class="orgName">
      <xsl:if test="@ana">
        <xsl:attribute name="data-ana"><xsl:value-of select="@ana"/></xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- Riferimento generico <rs> -->
  <xsl:template match="tei:rs">
    <span class="rs">
      <xsl:if test="@type">
        <xsl:attribute name="data-type"><xsl:value-of select="@type"/></xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- Correzioni <choice><sic>/<corr> -->
  <xsl:template match="tei:choice[tei:sic and tei:corr]">
    <span class="choice">
      <xsl:attribute name="title">Originale: <xsl:value-of select="tei:sic"/></xsl:attribute>
      <xsl:value-of select="tei:corr"/>
    </span>
  </xsl:template>

  <!-- Normalizzazioni <choice><orig>/<reg> -->
  <xsl:template match="tei:orig">
    <span class="orig"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- Lingua straniera -->
  <xsl:template match="tei:foreign">
    <em class="foreign" lang="{@xml:lang}"><xsl:apply-templates/></em>
  </xsl:template>

  <!-- Titolo di opera -->
  <xsl:template match="tei:title">
    <span class="title">
      <xsl:if test="@ana">
        <xsl:attribute name="data-ana"><xsl:value-of select="@ana"/></xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- Data nel testo -->
  <xsl:template match="tei:date">
    <span class="date">
      <xsl:if test="@ana">
        <xsl:attribute name="data-ana"><xsl:value-of select="@ana"/></xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- Citazione diretta -->
  <xsl:template match="tei:quote[not(tei:lg)]">
    <span class="quote"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- Distinzione arcaica/letteraria -->
  <xsl:template match="tei:distinct">
    <span class="distinct" data-type="{@type}"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- Frase idiomatica -->
  <xsl:template match="tei:phr">
    <span class="phr"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- Forma menzionata -->
  <xsl:template match="tei:mentioned">
    <em class="mentioned"><xsl:apply-templates/></em>
  </xsl:template>

  <!-- Ruolo sociale -->
  <xsl:template match="tei:roleName">
    <span class="roleName"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- A capo <lb>: non produce nulla di visibile -->
  <xsl:template match="tei:lb"/>

  <!-- Cambio colonna <cb>: non produce nulla di visibile -->
  <xsl:template match="tei:cb"/>


  <!-- BACK: APPENDICE (glossario + indice nomi)-->
  <xsl:template match="tei:back">
    <div id="back">
      <div id="appendice">
        <h2 id="appendice-titolo">
          <xsl:value-of select="tei:div[@type='appendice']/tei:head"/>
        </h2>
        <div id="appendice-layout">

          <!-- GLOSSARIO -->
          <div id="glossario">
            <h3>Glossario</h3>
            <xsl:apply-templates select="//tei:entry"/>
          </div>

          <!-- INDICE DEI NOMI -->
          <div id="indice-persone">
            <h3>Indice dei nomi</h3>
            <xsl:apply-templates select="//tei:listPerson/tei:person"/>
          </div>

          <!-- INDICE DEI LUOGHI -->
          <div id="indice-luoghi">
            <h3>Indice dei luoghi</h3>
            <xsl:apply-templates select="//tei:listPlace/tei:place"/>
          </div>

          <!-- INDICE DELLE ORGANIZZAZIONI -->
          <div id="indice-organizzazioni">
            <h3>Indice delle organizzazioni</h3>
            <xsl:apply-templates select="//tei:listOrg/tei:org"/>
          </div>

        </div>
      </div>
    </div>
  </xsl:template>


  <!-- VOCE GLOSSARIO -->
  <xsl:template match="tei:entry">
    <div class="glossario-entry">
      <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
      <span class="glossario-form"><xsl:value-of select="tei:form"/></span>
      <p class="glossario-def"><xsl:value-of select="tei:def"/></p>
      <xsl:if test="tei:ref/@target">
        <a class="glossario-ref">
          <xsl:attribute name="href"><xsl:value-of select="tei:ref/@target"/></xsl:attribute>
          Treccani ↗
        </a>
      </xsl:if>
    </div>
  </xsl:template>


  <!-- PERSONA -->
  <xsl:template match="tei:person">
    <div class="persona-card">
      <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
      <p class="persona-nome">
        <xsl:value-of select="tei:persName/tei:forename"/>
        <xsl:if test="tei:persName/tei:surname">
          <xsl:text> </xsl:text>
          <xsl:value-of select="tei:persName/tei:surname"/>
        </xsl:if>
        <xsl:if test="tei:persName/tei:addName">
          <xsl:text> </xsl:text>
          <span class="persona-epiteto">
            (<xsl:value-of select="tei:persName/tei:addName"/>)
          </span>
        </xsl:if>
        <!-- Casi senza forename: usa il testo diretto del persName -->
        <xsl:if test="not(tei:persName/tei:forename) and not(tei:persName/tei:addName)">
          <xsl:value-of select="normalize-space(tei:persName)"/>
        </xsl:if>
      </p>
      <xsl:if test="tei:note">
        <p class="persona-nota"><xsl:value-of select="tei:note"/></p>
      </xsl:if>
      <xsl:if test="tei:persName/tei:ref/@target">
        <a class="persona-ref">
          <xsl:attribute name="href">
            <xsl:value-of select="tei:persName/tei:ref/@target"/>
          </xsl:attribute>
          ↗
        </a>
      </xsl:if>
    </div>
  </xsl:template>
  <!-- LUOGO -->
  <xsl:template match="tei:place">
    <div class="persona-card">
      <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
      <p class="persona-nome">
        <xsl:value-of select="tei:placeName[1]"/>
      </p>
      <xsl:if test="tei:location/tei:region">
        <p class="persona-nota">
          <xsl:value-of select="tei:location/tei:region"/>,
          <xsl:text> </xsl:text>
          <xsl:value-of select="tei:location/tei:country"/>
        </p>
      </xsl:if>
      <xsl:if test="not(tei:location/tei:region) and tei:location/tei:country">
        <p class="persona-nota">
          <xsl:value-of select="tei:location/tei:country"/>
        </p>
      </xsl:if>
      <xsl:if test="tei:note[not(@type='url')]">
        <p class="persona-nota"><xsl:value-of select="tei:note[not(@type='url')]"/></p>
      </xsl:if>
      <xsl:if test="tei:ptr[@type='url']/@target">
        <a class="persona-ref">
          <xsl:attribute name="href">
            <xsl:value-of select="tei:ptr[@type='url']/@target"/>
          </xsl:attribute>
          Treccani ↗
        </a>
      </xsl:if>
    </div>
  </xsl:template>


  <!-- ORGANIZZAZIONE -->
  <xsl:template match="tei:org">
    <div class="persona-card">
      <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
      <p class="persona-nome">
        <xsl:value-of select="tei:orgName[@full='yes']"/>
      </p>
      <xsl:if test="tei:location/tei:settlement">
        <p class="persona-nota">
          <xsl:value-of select="tei:location/tei:settlement"/>
        </p>
      </xsl:if>
      <xsl:if test="tei:note">
        <p class="persona-nota"><xsl:value-of select="tei:note"/></p>
      </xsl:if>
      <xsl:if test="tei:ptr[@type='url']/@target">
        <a class="persona-ref">
          <xsl:attribute name="href">
            <xsl:value-of select="tei:ptr[@type='url']/@target"/>
          </xsl:attribute>
          ↗
        </a>
      </xsl:if>
    </div>
  </xsl:template>


</xsl:stylesheet>
