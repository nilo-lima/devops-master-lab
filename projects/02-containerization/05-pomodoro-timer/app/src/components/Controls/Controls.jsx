import { useEffect } from 'react'
import { usePomodoro } from '../../context/PomodoroContext'
import styles from './Controls.module.css'

async function requestNotifications() {
  if ('Notification' in window && Notification.permission === 'default') {
    await Notification.requestPermission()
  }
}

export function Controls() {
  const { state, start, pause, reset } = usePomodoro()
  const isRunning = state.status === 'running'
  const isPaused  = state.status === 'paused'

  // Atalhos: Espaço = iniciar/pausar | Escape = resetar
  useEffect(() => {
    const handle = (e) => {
      if (e.target.tagName === 'INPUT') return
      if (e.code === 'Space')  { e.preventDefault(); isRunning ? pause() : start() }
      if (e.code === 'Escape') reset()
    }
    window.addEventListener('keydown', handle)
    return () => window.removeEventListener('keydown', handle)
  }, [isRunning, start, pause, reset])

  const handleStart = () => { requestNotifications(); start() }

  return (
    <div className={styles.controls} role="group" aria-label="Controles do timer">
      <button
        className={`${styles.btn} ${styles.primary}`}
        onClick={isRunning ? pause : handleStart}
        aria-label={isRunning ? 'Pausar timer' : 'Iniciar timer'}
      >
        {isRunning ? '⏸ Pausar' : isPaused ? '▶ Retomar' : '▶ Iniciar'}
      </button>
      <button
        className={`${styles.btn} ${styles.secondary}`}
        onClick={reset}
        aria-label="Resetar timer"
      >
        ↺ Resetar
      </button>
    </div>
  )
}
