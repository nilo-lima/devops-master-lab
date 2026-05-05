import { usePomodoro } from '../../context/PomodoroContext'
import styles from './ModeSelector.module.css'

const MODES = [
  { id: 'work',       label: 'Trabalho'    },
  { id: 'shortBreak', label: 'Pausa Curta' },
  { id: 'longBreak',  label: 'Pausa Longa' },
]

export function ModeSelector() {
  const { state, setMode } = usePomodoro()

  return (
    <nav className={styles.nav} role="tablist" aria-label="Modo do timer">
      {MODES.map(({ id, label }) => (
        <button
          key={id}
          role="tab"
          aria-selected={state.mode === id}
          className={`${styles.tab} ${state.mode === id ? styles.active : ''} ${styles[id]}`}
          onClick={() => setMode(id)}
        >
          {label}
        </button>
      ))}
    </nav>
  )
}
