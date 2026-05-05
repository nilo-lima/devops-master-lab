import { useRef, useEffect } from 'react'
import { usePomodoro } from '../../context/PomodoroContext'
import styles from './Settings.module.css'

const FIELDS = [
  { key: 'work',       label: 'Trabalho (min)',    min: 1, max: 60 },
  { key: 'shortBreak', label: 'Pausa Curta (min)', min: 1, max: 30 },
  { key: 'longBreak',  label: 'Pausa Longa (min)', min: 1, max: 60 },
]

export function Settings({ onClose }) {
  const { state, updateSettings } = usePomodoro()
  const panelRef = useRef(null)

  useEffect(() => {
    panelRef.current?.focus()
    const handle = (e) => { if (e.key === 'Escape') onClose() }
    window.addEventListener('keydown', handle)
    return () => window.removeEventListener('keydown', handle)
  }, [onClose])

  const handleChange = (key, value) => {
    const num = parseInt(value, 10)
    if (!isNaN(num) && num > 0) updateSettings({ [key]: num })
  }

  return (
    <div
      ref={panelRef}
      className={styles.panel}
      role="dialog"
      aria-label="Configurações do Pomodoro"
      tabIndex={-1}
    >
      <div className={styles.header}>
        <h2 className={styles.title}>Configurações</h2>
        <button className={styles.closeBtn} onClick={onClose} aria-label="Fechar configurações">✕</button>
      </div>
      <div className={styles.fields}>
        {FIELDS.map(({ key, label, min, max }) => (
          <label key={key} className={styles.field}>
            <span>{label}</span>
            <input
              type="number"
              min={min}
              max={max}
              value={state.settings[key]}
              onChange={(e) => handleChange(key, e.target.value)}
              className={styles.input}
            />
          </label>
        ))}
      </div>
    </div>
  )
}
