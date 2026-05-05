import { usePomodoro } from '../../context/PomodoroContext'
import styles from './Timer.module.css'

const R = 88
const CIRC = 2 * Math.PI * R

const ACCENT = {
  work:       'var(--color-work)',
  shortBreak: 'var(--color-short)',
  longBreak:  'var(--color-long)',
}

const STATUS_LABEL = {
  idle:      'Pronto',
  running:   'Em andamento',
  paused:    'Pausado',
  completed: 'Concluído!',
}

export function Timer() {
  const { state } = usePomodoro()
  const { timeLeft, mode, status, settings } = state
  const accent = ACCENT[mode]
  const offset = CIRC * (1 - timeLeft / (settings[mode] * 60))
  const mm = Math.floor(timeLeft / 60).toString().padStart(2, '0')
  const ss = (timeLeft % 60).toString().padStart(2, '0')

  return (
    <div
      className={styles.container}
      role="timer"
      aria-live="polite"
      aria-atomic="true"
      aria-label={`${mm} minutos e ${ss} segundos restantes`}
    >
      <svg viewBox="0 0 200 200" className={styles.svg} aria-hidden="true">
        <circle cx="100" cy="100" r={R} fill="none" stroke="var(--border)" strokeWidth="8" />
        <circle
          cx="100" cy="100" r={R}
          fill="none"
          stroke={accent}
          strokeWidth="8"
          strokeLinecap="round"
          strokeDasharray={CIRC}
          strokeDashoffset={offset}
          transform="rotate(-90 100 100)"
          style={{ transition: 'stroke-dashoffset 0.9s linear, stroke 0.3s ease' }}
        />
      </svg>
      <div className={styles.display}>
        <time className={styles.time} style={{ color: accent }}>{mm}:{ss}</time>
        <span className={styles.status}>{STATUS_LABEL[status]}</span>
      </div>
    </div>
  )
}
