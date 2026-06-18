export default function Footer() {
  const badges = [
    'Marine Corps Veteran',
    'Security Cleared',
    'SAM.gov Registered',
    'SDVOSB Certified',
    'Bilingual JP / EN',
  ]

  const footerLinks = [
    {
      heading: 'COMPANY',
      links: ['About', 'Leadership', 'Capabilities', 'Careers'],
    },
    {
      heading: 'SERVICES',
      links: ['Cybersecurity', 'Gov Consulting', 'Cross-Border', 'Compliance'],
    },
    {
      heading: 'RESOURCES',
      links: ['Insights', 'Industries', 'Contact', 'Capabilities PDF'],
    },
  ]

  return (
    <footer id="contact" className="bg-navy-dark px-8 pt-18 pb-0">
      <div className="max-w-7xl mx-auto">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-[1.5fr_1fr_1fr_1fr] gap-12 pb-14 border-b border-white/10">
          <div className="max-w-full md:col-span-2 lg:col-span-1">
            <div className="flex items-center gap-3.5 mb-5">
              <div className="w-10 h-10 border-[1.5px] border-gold flex items-center justify-center font-serif font-bold text-base text-gold">
                OO
              </div>
              <div className="flex flex-col leading-tight">
                <span className="font-serif font-bold text-base tracking-[0.16em] text-white">
                  OSAKA OAKS
                </span>
                <span className="text-[9px] tracking-[0.42em] text-gold mt-0.5">
                  L L C
                </span>
              </div>
            </div>

            <p className="text-sm leading-relaxed text-white/55 max-w-xs mb-5">
              Veteran-owned cybersecurity, defense consulting, and U.S.–Japan advisory. Government-contract ready.
            </p>

            <div className="flex flex-col gap-2 text-sm text-white/70">
              <a
                href="tel:+18328475186"
                className="hover:text-gold transition-colors"
              >
                (832) 847-5186
              </a>
              <a
                href="mailto:jarrel.spiller@osakaoaks.org"
                className="hover:text-gold transition-colors"
              >
                jarrel.spiller@osakaoaks.org
              </a>
              <span className="text-white/50 leading-relaxed mt-1.5">
                6212 Belgrave Dr,<br />
                Austin, Texas 78747
              </span>
            </div>
          </div>

          {footerLinks.map((column) => (
            <div key={column.heading}>
              <div className="text-[11.5px] tracking-[0.2em] text-gold font-bold mb-5">
                {column.heading}
              </div>
              <div className="flex flex-col gap-3">
                {column.links.map((link) => (
                  <a
                    key={link}
                    href="#"
                    className="text-sm text-white/70 hover:text-white transition-colors"
                  >
                    {link}
                  </a>
                ))}
              </div>
            </div>
          ))}
        </div>

        <div className="flex flex-wrap gap-2.5 py-8 border-b border-white/10">
          {badges.map((badge) => (
            <div
              key={badge}
              className="inline-flex items-center gap-2 border border-gold/30 px-3.5 py-2 text-xs font-semibold text-white/80 tracking-tight"
            >
              <span className="w-1.5 h-1.5 bg-gold rotate-45" />
              {badge}
            </div>
          ))}
        </div>

        <div className="flex flex-wrap items-center justify-between gap-5 py-7 pb-10">
          <div className="text-xs text-white/40">
            © 2026 Osaka Oaks LLC. All rights reserved.
          </div>
          <div className="flex flex-wrap gap-5 font-mono text-[11.5px] text-white/50 tracking-tight">
            <span>UEI: MUGPMK51DFB4</span>
            <span>CAGE: 11WZ2</span>
            <span>SAM.gov Active thru Apr 2027</span>
          </div>
        </div>
      </div>
    </footer>
  )
}
