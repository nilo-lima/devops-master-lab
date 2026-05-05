import { useEffect } from 'react'
import { usePomodoro } from '../context/PomodoroContext'
import { useSound } from './useSound'

const MODE_LABELS = {
  work: '🍅 Trabalho',
  shortBreak: '☕ Pausa Curta',
  longBreak: '🌿 Pausa Longa',
}

export function useTimer() {
  const { state, tick, complete } = usePomodoro()
  const { playComplete } = useSound()

  // Intervalo: dispara tick() a cada segundo enquanto status === 'running'
  useEffect(() => {
    if (state.status !== 'running') return
    const id = setInterval(tick, 1000)
    return () => clearInterval(id)
  }, [state.status, tick])

  // Conclusão: toca som, notifica e avança para a próxima sessão após 1.5s
  useEffect(() => {
    if (state.status !== 'completed') return
    playComplete()
    if ('Notification' in window && Notification.permission === 'granted') {
      new Notification('Pomodoro Timer', { body: `${MODE_LABELS[state.mode]} concluída!` })
    }
    const id = setTimeout(complete, 1500)
    return () => clearTimeout(id)
  }, [state.status, state.mode, complete, playComplete])

  // Atualiza o título da aba com o tempo restante
  useEffect(() => {
    const m = Math.floor(state.timeLeft / 60).toString().padStart(2, '0')
    const s = (state.timeLeft % 60).toString().padStart(2, '0')
    document.title = `${m}:${s} — ${MODE_LABELS[state.mode]}`
    return () => { document.title = 'Pomodoro Timer' }
  }, [state.timeLeft, state.mode])
}
