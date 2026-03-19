<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8" indent="yes" />
    <xsl:template match="/">
        <xsl:for-each select="//libro">
            <article class="card" data-category="{@categoria}">
                <figure>
                    <img src="https://covers.openlibrary.org/b/isbn/{ISBN}-M.jpg" alt="{titulo}"
                        loading="lazy" />
                    <figcaption>
                        <h3>
                            <xsl:value-of select="titulo" />
                        </h3>
                        <p class="author">
                            <xsl:value-of select="autor" />
                        </p>
                    </figcaption>
                </figure>
                <button class="add-to-cart"
                    data-id="{ISBN}"
                    data-precio="{precio}">

                    texto <xsl:value-of
                        select="precio" />€ </button>
            </article>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>