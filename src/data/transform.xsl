<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8" indent="yes" />

    <xsl:param name="busqueda" select="''" />
    <xsl:param name="catsSeleccionadas" select="'|Todos|'" />
    <xsl:param name="minPrecio" select="0" />
    <xsl:param name="maxPrecio" select="999" />
    <xsl:param name="orden" select="'ascending'" />

    <xsl:variable name="mayus" select="'ABCDEFGHIJKLMN&#209;OPQRSTUVWXYZ&#193;&#201;&#205;&#211;&#218;&#220;'" />
    <xsl:variable name="minus" select="'abcdefghijklmn&#241;opqrstuvwxyz&#225;&#233;&#237;&#243;&#250;&#252;'" />

    <xsl:template match="/">
        <xsl:variable
            name="busquedaNormalizada"
            select="translate(normalize-space($busqueda), $mayus, $minus)"
        />

        <xsl:variable
            name="librosFiltrados"
            select="//libro[
                (contains($catsSeleccionadas, '|Todos|') or contains($catsSeleccionadas, concat('|', @categoria, '|'))) and
                (number(precio) &gt;= number($minPrecio) and number(precio) &lt;= number($maxPrecio)) and
                (
                    string-length($busquedaNormalizada) = 0 or
                    contains(
                        translate(normalize-space(titulo/text()), $mayus, $minus),
                        $busquedaNormalizada
                    ) or
                    contains(
                        translate(normalize-space(autor/text()), $mayus, $minus),
                        $busquedaNormalizada
                    )
                )
            ]"
        />

        <xsl:choose>
            <xsl:when test="$orden = 'descending'">
                <xsl:for-each select="$librosFiltrados">
                    <xsl:sort select="number(precio)" data-type="number" order="descending" />
                    <xsl:call-template name="render-card" />
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="$librosFiltrados">
                    <xsl:sort select="number(precio)" data-type="number" order="ascending" />
                    <xsl:call-template name="render-card" />
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="render-card">
        <article class="card" data-category="{@categoria}">
            <a class="card-link" href="/libro/{ISBN}">
                <img
                    src="https://covers.openlibrary.org/b/isbn/{ISBN}-M.jpg"
                    alt="{titulo}"
                    loading="lazy"
                    onerror="this.onerror=null;this.src='https://placehold.co/300x450/f5f5dc/8b5e3c?text=Sin+Portada';"
                />
                <div class="card-copy">
                    <h3><xsl:value-of select="titulo" /></h3>
                    <p class="author"><xsl:value-of select="autor" /></p>
                </div>
            </a>
            <button class="add-to-cart" data-id="{ISBN}" data-precio="{precio}">
                <xsl:value-of select="precio" />€
            </button>
        </article>
    </xsl:template>
</xsl:stylesheet>
