import { ArrowRight } from 'lucide-react'
import OakTree from './OakTree'

export default function Hero({ language }) {
  return (
    <header className="relative bg-gradient-radial from-navy-light via-navy to-navy overflow-hidden">
      <OakTree />
      <div className="relative max-w-7xl mx-auto px-8 py-28 lg:py-32">
        <div className="inline-flex items-center gap-2.5 border border-gold/40 px-4 py-2 mb-9">
          <span className="w-1.5 h-1.5 bg-gold rotate-45" />
          <span className="text-[11.5px] tracking-[0.22em] text-gold font-medium">
            SERVICE-DISABLED VETERAN-OWNED (SDVOSB) · SAM.GOV ACTIVE
          </span>
        </div>

        <h1 className="font-serif font-bold text-gold text-5xl lg:text-6xl leading-tight tracking-tight mb-8 max-w-3xl">
          Veteran-Led.<br />
          Security-Cleared.<br />
          Globally Connected.
        </h1>

        {language === 'EN' ? (
          <>
            <p className="text-lg lg:text-xl text-white/90 max-w-2xl mb-3 leading-relaxed">
              Cybersecurity, defense consulting, and U.S.–Japan cross-border advisory for government and enterprise.
            </p>
            <p className="text-sm lg:text-base text-white/50 max-w-2xl mb-10 leading-loose">
              官公庁・企業向けのサイバーセキュリティ、防衛コンサルティング、日米クロスボーダー支援。
            </p>
          </>
        ) : (
          <>
            <p className="text-lg lg:text-xl text-white/90 max-w-2xl mb-3 leading-loose">
              官公庁・企業向けのサイバーセキュリティ、防衛コンサルティング、日米クロスボーダー支援。
            </p>
            <p className="text-sm lg:text-base text-white/50 max-w-2xl mb-10 leading-relaxed">
              Cybersecurity, defense consulting, and U.S.–Japan cross-border advisory for government and enterprise.
            </p>
          </>
        )}

        <div className="flex flex-wrap gap-3.5">
          <a
            href="#contact"
            className="inline-flex items-center gap-2.5 bg-gold text-navy px-8 py-4 font-bold text-sm tracking-tight hover:bg-gold-light transition-colors"
          >
            Request a Consultation
            <ArrowRight className="w-4 h-4" />
          </a>
          <a
            href="#capabilities"
            className="inline-flex items-center px-8 py-4 font-semibold text-sm border border-white/30 text-white hover:border-gold hover:text-gold transition-colors"
          >
            View Capabilities
          </a>
        </div>
      </div>
    </header>
  )
}
