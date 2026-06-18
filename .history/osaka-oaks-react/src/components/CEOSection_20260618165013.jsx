import { motion } from 'framer-motion'
import { Badge } from './ui/badge'

export default function CEOSection() {
  const credentials = [
    'U.S. Marine Corps Veteran',
    'Active Security Clearance',
    'Bilingual — English / Japanese',
    '15+ years in defense & cyber',
  ]

  const naicsCodes = ['541512', '541519', '541611', '541690', '561621']

  return (
    <section id="about" className="bg-cream px-8 py-24">
      <div className="max-w-7xl mx-auto grid grid-cols-1 lg:grid-cols-[380px_1fr] gap-16">
        <div className="flex flex-col">
          <div className="aspect-square bg-gradient-radial from-navy-light via-navy to-navy border-2 border-gold flex flex-col items-center justify-center gap-4 mb-5">
            <div className="w-32 h-32 border-[1.5px] border-gold/50 rounded-full flex items-center justify-center">
              <span className="font-serif font-bold text-5xl text-gold tracking-tight">
                JS
              </span>
            </div>
            <span className="text-[11px] tracking-[0.24em] text-gold/90 font-semibold">
              JARREL SPILLER · CEO
            </span>
          </div>

          <div className="border-l-2 border-gold pl-3.5">
            <div className="text-sm font-bold text-navy">Jarrel Spiller</div>
            <div className="text-xs text-gray-600 mt-1">
              Founder & Chief Executive Officer
            </div>
          </div>
        </div>

        <div className="max-w-full">
          <div className="text-xs tracking-[0.16em] text-green font-bold mb-4">
            LEADERSHIP
          </div>
          <h2 className="font-serif font-bold text-4xl lg:text-[40px] leading-tight text-navy tracking-tight mb-6">
            A Marine's discipline.<br />
            A diplomat's reach.
          </h2>

          <p className="text-base leading-loose text-gray-700 mb-4 max-w-2xl">
            Jarrel Spiller founded Osaka Oaks to bring military-grade security discipline to the demands of modern government and enterprise contracting. A U.S. Marine Corps veteran with active clearance and fluency in Japanese, he bridges American defense rigor with the relationships and cultural fluency that cross-border work requires.
          </p>

          <p className="text-base leading-loose text-gray-700 mb-10 max-w-2xl">
            The result is a firm that operates with mission focus, communicates in two languages, and meets the documentation and compliance bar that government partners expect.
          </p>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-x-9 gap-y-3.5 mb-10 max-w-2xl">
            {credentials.map((cred) => (
              <div
                key={cred}
                className="flex items-center gap-3 py-2 border-b border-navy/10"
              >
                <span className="w-2 h-2 bg-gold rotate-45 flex-none" />
                <span className="text-sm text-navy font-medium">{cred}</span>
              </div>
            ))}
          </div>

          <div className="mt-10">
            <div className="text-[11px] tracking-[0.2em] text-gray-600 font-bold mb-3">
              NAICS CODES
            </div>
            <div className="flex flex-wrap gap-2">
              {naicsCodes.map((code) => (
                <span
                  key={code}
                  className="font-mono text-sm font-semibold text-navy bg-white border border-navy/20 px-3.5 py-2 tracking-tight"
                >
                  {code}
                </span>
              ))}
            </div>
          </div>
        </div>
      </div>
    </section>
  )
}
