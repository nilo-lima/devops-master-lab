import { createContext, useContext, useReducer, useCallback } from 'react'

const SESSIONS_BEFORE_LONG = 4
const DEFAULT_SETTINGS = { work: 25, shortBreak: 5, longBreak: 15 }

const initialState = {
  mode: 'work',
  status: 'idle',
  timeLeft: DEFAULT_SETTINGS.work * 60,
  sessions: 0,
  settings: DEFAULT_SETTINGS,
}

function getTimeForMode(mode, settings) {
  return settings[mode] * 60
}

function getNextMode(currentMode, sessions) {
  if (currentMode !== 'work') return 'work'
  return sessions % SESSIONS_BEFORE_LONG === 0 ? 'longBreak' : 'shortBreak'
}

function reducer(state, action) {
  switch (action.type) {
    case 'START':
      return { ...state, status: 'running' }

    case 'PAUSE':
      return { ...state, status: 'paused' }

    case 'RESET':
      return { ...state, status: 'idle', timeLeft: getTimeForMode(state.mode, state.settings) }

    case 'TICK':
      if (state.timeLeft <= 1) return { ...state, timeLeft: 0, status: 'completed' }
      return { ...state, timeLeft: state.timeLeft - 1 }

    case 'COMPLETE': {
      const newSessions = state.mode === 'work' ? state.sessions + 1 : state.sessions
      const nextMode = getNextMode(state.mode, newSessions)
      return {
        ...state,
        mode: nextMode,
        status: 'idle',
        sessions: newSessions,
        timeLeft: getTimeForMode(nextMode, state.settings),
      }
    }

    case 'SET_MODE':
      return {
        ...state,
        mode: action.mode,
        status: 'idle',
        timeLeft: getTimeForMode(action.mode, state.settings),
      }

    case 'UPDATE_SETTINGS': {
      const settings = { ...state.settings, ...action.settings }
      return { ...state, settings, status: 'idle', timeLeft: getTimeForMode(state.mode, settings) }
    }

    default:
      return state
  }
}

const PomodoroContext = createContext(null)

export function PomodoroProvider({ children }) {
  const [state, dispatch] = useReducer(reducer, initialState)

  const start          = useCallback(() => dispatch({ type: 'START' }), [])
  const pause          = useCallback(() => dispatch({ type: 'PAUSE' }), [])
  const reset          = useCallback(() => dispatch({ type: 'RESET' }), [])
  const tick           = useCallback(() => dispatch({ type: 'TICK' }), [])
  const complete       = useCallback(() => dispatch({ type: 'COMPLETE' }), [])
  const setMode        = useCallback((mode) => dispatch({ type: 'SET_MODE', mode }), [])
  const updateSettings = useCallback((s) => dispatch({ type: 'UPDATE_SETTINGS', settings: s }), [])

  return (
    <PomodoroContext.Provider value={{ state, start, pause, reset, tick, complete, setMode, updateSettings }}>
      {children}
    </PomodoroContext.Provider>
  )
}

export function usePomodoro() {
  const ctx = useContext(PomodoroContext)
  if (!ctx) throw new Error('usePomodoro must be used within PomodoroProvider')
  return ctx
}
