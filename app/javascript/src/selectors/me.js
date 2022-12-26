export const getMe = (state) => state.me.me
export const isAuthenticated = (state) => !!state.me.me.id

export const meSelector = (state) => state.me.me
export const isAuthenticatedSelector = (state) => !!state.me.me.id
export const myNameOrEmailSelector = (state) => state.me.me.firstName || state.me.me.email
