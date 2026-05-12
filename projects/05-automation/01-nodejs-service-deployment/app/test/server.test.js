const request = require('supertest');
const { app, server } = require('../src/server');

afterAll(() => server.close());

describe('GET /', () => {
  it('retorna 200 com message e uptime', async () => {
    const res = await request(app).get('/');
    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty('message', 'Hello, world!');
    expect(res.body).toHaveProperty('uptime_seconds');
    expect(typeof res.body.uptime_seconds).toBe('number');
  });
});

describe('GET /health', () => {
  it('retorna 200 com status ok', async () => {
    const res = await request(app).get('/health');
    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty('status', 'ok');
    expect(res.body).toHaveProperty('timestamp');
  });
});

describe('Rotas inexistentes', () => {
  it('retorna 404 para rota desconhecida', async () => {
    const res = await request(app).get('/nao-existe');
    expect(res.statusCode).toBe(404);
  });
});
