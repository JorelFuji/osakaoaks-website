import { useState } from 'react'
import TopBar from './components/TopBar'
import Navigation from './components/Navigation'
import Hero from './components/Hero'
import TrustBadges from './components/TrustBadges'
import Services from './components/Services'
import CEOSection from './components/CEOSection'
import Capabilities from './components/Capabilities'
import JapaneseServices from './components/JapaneseServices'
import Footer from './components/Footer'

function App() {
  const [language, setLanguage] = useState('EN')

  return (
    <div className="min-h-screen bg-navy">
      <TopBar language={language} setLanguage={setLanguage} />
      <Navigation />
      <Hero language={language} />
      <TrustBadges />
      <Services />
      <CEOSection />
      <Capabilities />
      <JapaneseServices />
      <Footer />
    </div>
  )
}

export default App
