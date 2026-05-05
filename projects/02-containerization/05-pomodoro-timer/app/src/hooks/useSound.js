import { useRef, useCallback } from 'react'

export function useSound() {
  const ctxRef = useRef(null)

  const getCtx = () => {
    if (!ctxRef.current) {
      ctxRef.current = new (window.AudioContext || window.webkitAudioContext)()
    }
    return ctxRef.current
  }

  const beep = useCallback((freq, duration, volume = 0.4) => {
    try {
      const ctx = getCtx()
      const osc = ctx.createOscillator()
      const gain = ctx.createGain()
      osc.connect(gain)
      gain.connect(ctx.destination)
      osc.type = 'sine'
      osc.frequency.value = freq
      gain.gain.setValueAtTime(volume, ctx.currentTime)
      gain.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + duration)
      osc.start(ctx.currentTime)
      osc.stop(ctx.currentTime + duration)
    } catch {
      // AudioContext bloqueado antes de interação do usuário
    }
  }, [])

  const playComplete = useCallback(() => {
    beep(600, 0.2)
    setTimeout(() => beep(750, 0.2), 250)
    setTimeout(() => beep(900, 0.35, 0.5), 500)
  }, [beep])

  return { playComplete }
}
