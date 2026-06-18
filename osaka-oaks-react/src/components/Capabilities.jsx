import { Download } from 'lucide-react'

export default function Capabilities() {
  const competencies = [
    'Cybersecurity Consulting',
    'NIST / CMMC Compliance',
    'IT System Administration',
    'Federal Grant Writing',
    'Business English Training',
    'U.S.–Japan Cross-Border Advisory',
  ]

  const differentiators = [
    'SDVOSB · Marine Corps Veteran-Owned',
    'Active Security Clearance',
    'Bilingual English / Japanese',
    '15+ years defense & cyber',
  ]

  const naicsCodes = ['541512', '541519', '541611', '541690', '561621']

  return (
    <section id="capabilities" className="bg-navy px-8 py-24 border-t border-white/10">
      <div className="max-w-7xl mx-auto">
        <div className="flex flex-wrap items-end justify-between gap-6 mb-10">
          <div>
            <div className="text-xs tracking-[0.26em] text-gold font-semibold mb-4">
              CAPABILITIES STATEMENT
            </div>
            <h2 className="font-serif font-bold text-4xl lg:text-[42px] leading-tight text-white tracking-tight">
              Government-contract ready,<br />
              on one page.
            </h2>
          </div>
          <a
            href="#"
            className="inline-flex items-center gap-2.5 bg-gold text-navy px-7 py-4 font-bold text-sm tracking-tight hover:bg-gold-light transition-colors whitespace-nowrap"
          >
            Download PDF
            <Download className="w-4 h-4" />
          </a>
        </div>

        <div className="bg-white text-navy shadow-2xl">
          <div className="flex flex-wrap items-center justify-between gap-5 px-10 py-8 border-b-[3px] border-gold">
            <div className="flex items-center gap-4">
              <div className="w-[50px] h-[50px] flex-none border-[1.5px] border-gold flex items-center justify-center font-serif font-bold text-lg text-navy">
                OO
              </div>
              <div>
                <div className="font-serif font-bold text-2xl tracking-wider">
                  OSAKA OAKS LLC
                </div>
                <div className="text-[11.5px] tracking-[0.18em] text-gray-600 mt-0.5">
                  CAPABILITIES STATEMENT
                </div>
              </div>
            </div>
            <div className="text-[11px] tracking-wider text-green font-bold text-right leading-relaxed">
              SERVICE-DISABLED VETERAN-OWNED (SDVOSB)<br />
              SAM.gov Active · UEI MUGPMK51DFB4
            </div>
          </div>

          <div className="grid grid-cols-1 lg:grid-cols-2">
            <div className="px-10 py-9 lg:border-r border-navy/10 space-y-7">
              <div>
                <div className="text-[11px] tracking-wider text-gold-dark font-bold mb-2">
                  COMPANY
                </div>
                <div className="text-base font-semibold">Osaka Oaks LLC</div>
              </div>

              <div className="flex gap-10 flex-wrap">
                <div>
                  <div className="text-[11px] tracking-wider text-gold-dark font-bold mb-2">
                    UEI
                  </div>
                  <div className="font-mono text-sm font-semibold text-navy">
                    MUGPMK51DFB4
                  </div>
                </div>
                <div>
                  <div className="text-[11px] tracking-wider text-gold-dark font-bold mb-2">
                    CAGE CODE
                  </div>
                  <div className="font-mono text-sm font-semibold text-navy">
                    11WZ2
                  </div>
                </div>
              </div>

              <div className="flex gap-10 flex-wrap">
                <div>
                  <div className="text-[11px] tracking-wider text-gold-dark font-bold mb-2">
                    SAM.GOV STATUS
                  </div>
                  <div className="text-sm text-green font-semibold">
                    Active — Expires Apr 2, 2027
                  </div>
                </div>
                <div>
                  <div className="text-[11px] tracking-wider text-gold-dark font-bold mb-2">
                    STATE OF INCORPORATION
                  </div>
                  <div className="text-sm text-navy">Texas, United States</div>
                </div>
              </div>

              <div>
                <div className="text-[11px] tracking-wider text-gold-dark font-bold mb-2">
                  PHYSICAL ADDRESS
                </div>
                <div className="text-sm text-navy leading-relaxed">
                  6212 Belgrave Dr, Austin, Texas 78747
                </div>
              </div>

              <div>
                <div className="text-[11px] tracking-wider text-gold-dark font-bold mb-3">
                  NAICS CODES
                </div>
                <div className="flex flex-wrap gap-2">
                  {naicsCodes.map((code) => (
                    <span
                      key={code}
                      className="font-mono text-sm font-semibold text-navy bg-cream border border-navy/15 px-3 py-1.5"
                    >
                      {code}
                    </span>
                  ))}
                </div>
              </div>
            </div>

            <div className="px-10 py-9 space-y-7">
              <div>
                <div className="text-[11px] tracking-wider text-gold-dark font-bold mb-3">
                  CORE COMPETENCIES
                </div>
                <div className="grid grid-cols-2 gap-x-6 gap-y-2">
                  {competencies.map((comp) => (
                    <div key={comp} className="flex items-start gap-2">
                      <span className="w-1.5 h-1.5 bg-gold rotate-45 flex-none mt-1.5" />
                      <span className="text-[13.5px] leading-snug">{comp}</span>
                    </div>
                  ))}
                </div>
              </div>

              <div>
                <div className="text-[11px] tracking-wider text-gold-dark font-bold mb-3">
                  DIFFERENTIATORS
                </div>
                <div className="grid grid-cols-2 gap-x-6 gap-y-2">
                  {differentiators.map((diff) => (
                    <div key={diff} className="flex items-start gap-2">
                      <span className="w-1.5 h-1.5 bg-green rotate-45 flex-none mt-1.5" />
                      <span className="text-[13.5px] leading-snug">{diff}</span>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </div>

          <div className="grid grid-cols-1 lg:grid-cols-[1fr_1.2fr] gap-8 px-10 py-7 border-t border-navy/10 bg-cream">
            <div>
              <div className="text-[11px] tracking-wider text-gold-dark font-bold mb-2">
                PAST PERFORMANCE
              </div>
              <div className="text-sm text-gray-700 italic">
                Available upon request
              </div>
            </div>
            <div>
              <div className="text-[11px] tracking-wider text-gold-dark font-bold mb-2">
                POINT OF CONTACT
              </div>
              <div className="text-sm text-navy leading-relaxed">
                Jarrel Spiller, CEO<br />
                jarrel.spiller@osakaoaks.org · (832) 847-5186
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  )
}
