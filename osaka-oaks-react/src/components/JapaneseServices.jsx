export default function JapaneseServices() {
  const services = [
    {
      num: '壱',
      title: 'サイバーセキュリティ',
      body: 'ゼロトラスト設計と継続的なシステム監視で、組織の情報資産を保護します。',
    },
    {
      num: '弐',
      title: '補助金申請支援',
      body: '各種補助金・助成金の申請手続きを、書類作成から提出まで一貫して支援します。',
    },
    {
      num: '参',
      title: 'ビジネス英語研修',
      body: '実務に即した日英ビジネス英語研修で、国際的なコミュニケーション力を養成します。',
    },
  ]

  return (
    <section id="jp" className="bg-gradient-radial from-[#13294a] via-navy to-navy px-8 py-24 border-t border-gold/20">
      <div className="max-w-7xl mx-auto">
        <div className="flex items-center gap-3.5 mb-5">
          <span className="w-2 h-2 bg-gold rotate-45" />
          <span className="text-xs tracking-[0.22em] text-gold font-semibold">
            日本語でのサービス&nbsp;&nbsp;/&nbsp;&nbsp;SERVICES IN JAPANESE
          </span>
        </div>

        <h2 className="font-sans font-bold text-4xl lg:text-[38px] leading-snug text-gold tracking-tight mb-7">
          大阪オークス合同会社へようこそ
        </h2>

        <p className="font-sans text-base leading-loose text-white/85 max-w-4xl mb-12">
          私たちは大阪オークス合同会社です。米国海兵隊退役軍人が率いるサイバーセキュリティ・コンサルティング企業として、地方自治体、学校法人、および中小企業のデジタルセキュリティ強化と日米間のビジネス英語教育を専門としております。セキュリティクリアランスを保有し、日英両言語で高品質なサービスを提供します。
        </p>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
          {services.map((service) => (
            <div
              key={service.num}
              className="bg-[#0F1F33] border border-white/10 border-t-2 border-t-gold p-7 flex flex-col min-h-[180px]"
            >
              <div className="font-serif text-3xl text-gold font-semibold mb-4">
                {service.num}
              </div>
              <h3 className="font-sans font-bold text-xl text-white mb-3">
                {service.title}
              </h3>
              <p className="font-sans text-sm leading-loose text-white/60">
                {service.body}
              </p>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
