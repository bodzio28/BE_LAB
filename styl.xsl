<?xml version="1.0" encoding="UTF-8"?>
<xsl : stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Faktura</title>
        <style>
          body { font-family: Arial, sans-serif; margin: 20px; }
          .faktura { border: 1px solid #ccc; padding: 20px; max-width: 800px; margin: auto; }
          h1 { text-align: center; }
          .dane { display: flex; justify-content: space-between; margin-bottom: 20px; }
          .dane div { width: 48%; }
          table { width: 100%; border-collapse: collapse; }
          th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
          th { background-color: #f2f2f2; }
          .summary { text-align: right; margin-top: 20px; font-weight: bold; }
        </style>
      </head>
      <body>
        <div class="faktura">
          <h1>Faktura nr <xsl:value-of select="faktura/@numer"/></h1>
          <p>Data wystawienia: <xsl:value-of select="faktura/dataWystawienia"/></p>

          <div class="dane">
            <div>
              <h2>Sprzedawca</h2>
              <p>
                <xsl:value-of select="faktura/sprzedawca/nazwa"/><br/>
                <xsl:value-of select="faktura/sprzedawca/adres"/><br/>
                NIP: <xsl:value-of select="faktura/sprzedawca/nip"/>
              </p>
            </div>
            <div>
              <h2>Nabywca</h2>
              <p>
                <xsl:value-of select="faktura/nabywca/nazwa"/><br/>
                <xsl:value-of select="faktura/nabywca/adres"/><br/>
                NIP: <xsl:value-of select="faktura/nabywca/nip"/>
              </p>
            </div>
          </div>

          <h2>Pozycje na fakturze</h2>
          <table>
            <tr>
              <th>Lp.</th>
              <th>Nazwa</th>
              <th>Ilość</th>
              <th>Jm.</th>
              <th>Cena Netto</th>
              <th>VAT (%)</th>
              <th>Wartość Netto</th>
            </tr>
            
            <xsl:for-each select="faktura/pozycje/pozycja">
              <tr>
                <td><xsl:number value="position()" format="1"/></td>
                <td><xsl:value-of select="nazwa"/></td>
                <td><xsl:value-of select="ilosc"/></td>
                <td><xsl:value-of select="jednostka"/></td>
                <td><xsl:value-of select="cenaNetto"/> zł</td>
                <td><xsl:value-of select="stawkaVAT"/></td>
                <td><xsl:value-of select="format-number(ilosc * cenaNetto, '#,##0.00')"/> zł</td>
              </tr>
            </xsl:for-each>
          </table>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>