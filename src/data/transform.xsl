<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8" indent="yes" />

    <xsl:param name="busqueda" select="''" />
    <xsl:param name="catsSeleccionadas" select="'|Todos|'" />
    <xsl:param name="minPrecio" select="0" />
    <xsl:param name="maxPrecio" select="999" />
    <xsl:param name="orden" select="'ascending'" />

    <xsl:variable name="mayus" select="'ABCDEFGHIJKLMNÑOPQRSTUVWXYZÁÉÍÓÚ'" />
    <xsl:variable name="minus" select="'abcdefghijklmnñopqrstuvwxyzáéíóú'" />

    <xsl:template match="/">
        <xsl:for-each select="//libro[
            (contains($catsSeleccionadas, '|Todos|') or contains($catsSeleccionadas, concat('|', @categoria, '|'))) and
            (number(precio) &gt;= number($minPrecio) and number(precio) &lt;= number($maxPrecio)) and
            (
                contains(translate(titulo, $mayus, $minus), translate($busqueda, $mayus, $minus)) or 
                contains(translate(autor, $mayus, $minus), translate($busqueda, $mayus, $minus))
            )
        ]">
            <xsl:sort select="number(precio)" data-type="number" order="{$orden}" />

            <article class="card" data-category="{@categoria}">
                <figure>
                    <img src="https://covers.openlibrary.org/b/isbn/{ISBN}-M.jpg"
                        alt="{titulo}"
                        loading="lazy"
                        onerror="this.onerror=null;this.src='https://placehold.co/300x450/f5f5dc/8b5e3c?text=Sin+Portada';" />
                    <figcaption>
                        <h3><xsl:value-of select="titulo" /></h3>
                        <p class="author"><xsl:value-of select="autor" /></p>
                    </figcaption>
                </figure>
                <button class="add-to-cart" data-id="{ISBN}" data-precio="{precio}">
                    <xsl:value-of select="precio" />€
                </button>
            </article>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>