import { useState, useEffect } from 'react'
import { Menu, X } from 'lucide-react'

export default function Navigation() {
  const [isScrolled, setIsScrolled] = useState(false)
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false)

  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 50)
    }
    window.addEventListener('scroll', handleScroll)
    return () => window.removeEventListener('scroll', handleScroll)
  }, [])

  const navLinks = [
    { href: '#', label: 'Home' },
    { href: '#about', label: 'About' },
    { href: '#services', label: 'Services' },
    { href: '#capabilities', label: 'Capabilities' },
    { href: '#industries', label: 'Industries' },
    { href: '#insights', label: 'Insights' },
    { href: '#contact', label: 'Contact' },
  ]

  return (
    <nav className={`sticky top-0 z-50 bg-navy/95 backdrop-blur-sm border-b border-white/10 transition-shadow ${isScrolled ? 'shadow-lg' : ''}`}>
      <div className="max-w-7xl mx-auto px-8 py-4 flex items-center justify-between gap-8">
        <a href="#" className="flex items-center gap-3.5">
          <div className="w-10 h-10 border-[1.5px] border-gold flex items-center justify-center font-serif font-bold text-base text-gold tracking-wider">
            OO
          </div>
          <div className="flex flex-col leading-tight">
            <span className="font-serif font-bold text-[17px] tracking-[0.16em] text-white">
              OSAKA OAKS
            </span>
            <span className="text-[9.5px] tracking-[0.42em] text-gold mt-0.5">
              L L C
            </span>
          </div>
        </a>

        <div className="hidden lg:flex items-center gap-7 text-sm font-medium tracking-tight">
          {navLinks.map((link) => (
            <a
              key={link.href}
              href={link.href}
              className="text-white/80 hover:text-white transition-colors pb-0.5 border-b-[1.5px] border-transparent hover:border-gold"
            >
              {link.label}
            </a>
          ))}
          <a
            href="#contact"
            className="bg-gold text-navy px-5 py-2.5 font-bold text-[13px] tracking-tight hover:bg-gold-light transition-colors"
          >
            Request a Consultation
          </a>
        </div>

        <button 
          className="lg:hidden text-white"
          onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
        >
          {mobileMenuOpen ? <X size={24} /> : <Menu size={24} />}
        </button>
      </div>

      {mobileMenuOpen && (
        <div className="lg:hidden bg-navy/98 border-t border-white/10 py-4">
          {navLinks.map((link) => (
            <a
              key={link.href}
              href={link.href}
              className="block px-8 py-3 text-white/80 hover:text-white hover:bg-white/5 transition-colors"
              onClick={() => setMobileMenuOpen(false)}
            >
              {link.label}
            </a>
          ))}
          <a
            href="#contact"
            className="block mx-8 mt-4 bg-gold text-navy px-5 py-2.5 font-bold text-center"
            onClick={() => setMobileMenuOpen(false)}
          >
            Request a Consultation
          </a>
        </div>
      )}
    </nav>
  )
}
