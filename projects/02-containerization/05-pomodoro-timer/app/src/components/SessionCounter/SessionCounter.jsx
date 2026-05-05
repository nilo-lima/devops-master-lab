import { usePomodoro } from '../../context/PomodoroContext'
import styles from './SessionCounter.module.css'

export function SessionCounter() {
  const { state: { sessions } } = usePomodoro()

  return (
    <div className={styles.container}>
      <span className={styles.label}>Sessões</span>
      <div
        className={styles.tomatoes}
        role="img"
        aria-label={`${sessions % 4} de 4 sessões no ciclo atual`}
      >
        {Array.from({ length: 4 }, (_, i) => (
          <span key={i} className={`${styles.tomato} ${i < sessions % 4 ? styles.done : ''}`}>
            🍅
          </span>
        ))}
      </div>
      <span className={styles.total}>Total completas: {sessions}</span>
    </div>
  )
}
