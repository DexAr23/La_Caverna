<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8" indent="yes" />
    <xsl:template match="/">
        <xsl:for-each select="libreria/libro">
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

                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                        viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                        stroke-linecap="round" stroke-linejoin="round">

                        <circle cx="9" cy="21" r="1"></circle>

                        <circle cx="20" cy="21" r="1"></circle>

                        <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>

                    </svg> <xsl:value-of
                        select="precio" />€ </button>
            </article>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>