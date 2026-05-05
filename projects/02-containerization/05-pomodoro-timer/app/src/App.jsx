import { useState } from 'react'
import { PomodoroProvider, usePomodoro } from './context/PomodoroContext'
import { ModeSelector }   from './components/ModeSelector/ModeSelector'
import { Timer }          from './components/Timer/Timer'
import { Controls }       from './components/Controls/Controls'
import { SessionCounter } from './components/SessionCounter/SessionCounter'
import { Settings }       from './components/Settings/Settings'
import { useTimer }       from './hooks/useTimer'
import styles from './App.module.css'

const ACCENT = {
  work:       '#e63946',
  shortBreak: '#2a9d8f',
  longBreak:  '#457b9d',
}

function PomodoroApp() {
  const { state } = usePomodoro()
  const [showSettings, setShowSettings] = useState(false)
  useTimer()

  return (
    <main className={styles.main} style={{ '--accent': ACCENT[state.mode] }}>
      <header className={styles.header}>
        <h1 className={styles.title}>🍅 Pomodoro</h1>
        <button
          className={styles.settingsBtn}
          onClick={() => setShowSettings(s => !s)}
          aria-label="Configurações"
          aria-expanded={showSettings}
        >
          ⚙
        </button>
      </header>

      {showSettings && <Settings onClose={() => setShowSettings(false)} />}

      <ModeSelector />
      <Timer />
      <Controls />
      <SessionCounter />

      <footer className={styles.footer}>Espaço para pausar · Esc para resetar</footer>
    </main>
  )
}

export default function App() {
  return (
    <PomodoroProvider>
      <PomodoroApp />
    </PomodoroProvider>
  )
}
