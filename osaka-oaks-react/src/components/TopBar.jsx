import { Phone, Mail } from 'lucide-react'
import { cn } from '../lib/utils'

export default function TopBar({ language, setLanguage }) {
  return (
    <div className="bg-navy-dark border-b border-gold/20">
      <div className="max-w-7xl mx-auto px-8 py-2.5 flex items-center justify-between gap-6 text-xs tracking-wide">
        <div className="flex items-center gap-7 text-white/60">
          <a 
            href="tel:+18328475186" 
            className="flex items-center gap-2 hover:text-gold transition-colors"
          >
            <span className="w-1.5 h-1.5 bg-gold rounded-full" />
            (832) 847-5186
          </a>
          <a 
            href="mailto:jarrel.spiller@osakaoaks.org" 
            className="flex items-center gap-2 hover:text-gold transition-colors"
          >
            <span className="w-1.5 h-1.5 bg-gold rounded-full" />
            jarrel.spiller@osakaoaks.org
          </a>
        </div>
        <div className="flex items-center gap-0.5 font-medium">
          <button
            onClick={() => setLanguage('EN')}
            className={cn(
              "cursor-pointer transition-colors",
              language === 'EN' ? "text-gold font-bold" : "text-white/55"
            )}
          >
            EN
          </button>
          <span className="opacity-30 px-1">/</span>
          <button
            onClick={() => setLanguage('JP')}
            className={cn(
              "cursor-pointer transition-colors",
              language === 'JP' ? "text-gold font-bold" : "text-white/55"
            )}
          >
            日本語
          </button>
        </div>
      </div>
    </div>
  )
}
