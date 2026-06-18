export default function TrustBadges() {
  const badges = [
    'Marine Corps Veteran',
    'Security Cleared',
    'SAM.gov Registered',
    'SDVOSB Certified',
    'Bilingual JP / EN',
  ]

  return (
    <section className="bg-cream border-t-[3px] border-gold">
      <div className="max-w-7xl mx-auto px-8 py-8 flex flex-wrap items-center justify-between gap-6">
        {badges.map((badge) => (
          <div key={badge} className="flex items-center gap-3 flex-1 min-w-[175px]">
            <div className="w-[34px] h-[34px] flex-none border-[1.5px] border-green flex items-center justify-center">
              <span className="w-2.5 h-2.5 bg-green rotate-45" />
            </div>
            <span className="text-sm font-bold text-navy leading-tight tracking-tight">
              {badge}
            </span>
          </div>
        ))}
      </div>
    </section>
  )
}
