import { motion } from 'framer-motion'
import { Shield, Award, CheckCircle, Globe2, Languages } from 'lucide-react'

export default function TrustBadges() {
  const badges = [
    { label: 'Marine Corps Veteran', icon: Shield },
    { label: 'Security Cleared', icon: CheckCircle },
    { label: 'SAM.gov Registered', icon: Award },
    { label: 'SDVOSB Certified', icon: Award },
    { label: 'Bilingual JP / EN', icon: Languages },
  ]

  const containerVariants = {
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: {
        staggerChildren: 0.1
      }
    }
  }

  const itemVariants = {
    hidden: { opacity: 0, scale: 0.8 },
    visible: {
      opacity: 1,
      scale: 1,
      transition: { duration: 0.4 }
    }
  }

  return (
    <section className="bg-cream border-t-[3px] border-gold">
      <motion.div
        variants={containerVariants}
        initial="hidden"
        whileInView="visible"
        viewport={{ once: true }}
        className="max-w-7xl mx-auto px-8 py-8 flex flex-wrap items-center justify-between gap-6"
      >
        {badges.map((badge) => {
          const Icon = badge.icon
          return (
            <motion.div
              key={badge.label}
              variants={itemVariants}
              whileHover={{ scale: 1.05 }}
              className="flex items-center gap-3 flex-1 min-w-[175px]"
            >
              <div className="w-[34px] h-[34px] flex-none border-[1.5px] border-green flex items-center justify-center">
                <Icon className="w-4 h-4 text-green" />
              </div>
              <span className="text-sm font-bold text-navy leading-tight tracking-tight">
                {badge.label}
              </span>
            </motion.div>
          )
        })}
      </motion.div>
    </section>
  )
}
