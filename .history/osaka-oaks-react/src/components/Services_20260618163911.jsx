export default function Services() {
  const services = [
    {
      num: '01',
      title: 'Cybersecurity & Risk Management',
      body: 'Threat assessment, zero-trust architecture, and continuous monitoring built to federal security baselines.',
      tag: 'CYBER',
    },
    {
      num: '02',
      title: 'Defense & Government Consulting',
      body: 'Federal acquisition support, mission readiness, and program advisory for agencies and primes.',
      tag: 'CONSULTING',
    },
    {
      num: '03',
      title: 'U.S.–Japan Cross-Border Advisory',
      body: 'Bilingual market entry, partnership brokering, and regulatory navigation between the U.S. and Japan.',
      tag: 'GLOBAL',
    },
    {
      num: '04',
      title: 'Security Clearance & Compliance',
      body: 'NIST 800-171 and CMMC readiness, audit preparation, and cleared-personnel program support.',
      tag: 'COMPLIANCE',
    },
  ]

  return (
    <section id="services" className="bg-navy px-8 py-24">
      <div className="max-w-7xl mx-auto">
        <div className="flex items-end justify-between gap-8 mb-14 flex-wrap">
          <div>
            <div className="text-xs tracking-[0.26em] text-gold font-semibold mb-4">
              WHAT WE DO
            </div>
            <h2 className="font-serif font-bold text-4xl lg:text-[42px] leading-tight text-white tracking-tight">
              Mission-grade services,<br />
              built for the contract.
            </h2>
          </div>
          <p className="text-sm lg:text-base text-white/60 max-w-sm leading-relaxed">
            Disciplined delivery from a cleared, bilingual team — calibrated to federal standards and global engagement.
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-5">
          {services.map((service) => (
            <div
              key={service.num}
              className="bg-[#0F1F33] border border-white/10 border-t-2 border-t-gold p-8 flex flex-direction-col min-h-[300px] hover:border-gold/50 transition-colors group"
            >
              <div className="font-serif text-3xl text-gold font-semibold mb-5">
                {service.num}
              </div>
              <h3 className="font-serif font-semibold text-xl leading-tight text-white mb-3">
                {service.title}
              </h3>
              <p className="text-[13.5px] leading-relaxed text-white/60 flex-1">
                {service.body}
              </p>
              <div className="mt-5 text-[11px] tracking-[0.18em] text-gold font-semibold">
                {service.tag}
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
