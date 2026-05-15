const request = require('supertest');

process.env.APP_USERNAME = 'testuser';
process.env.APP_PASSWORD = 'testpass';
process.env.SECRET_MESSAGE = 'test-secret';

const { app, server } = require('../src/server');

afterAll(() => server.close());

describe('GET /', () => {
  it('returns 200 with status ok', async () => {
    const res = await request(app).get('/');
    expect(res.status).toBe(200);
    expect(res.body.status).toBe('ok');
  });
});

describe('GET /secret', () => {
  const validAuth = 'Basic ' + Buffer.from('testuser:testpass').toString('base64');
  const wrongAuth = 'Basic ' + Buffer.from('wrong:creds').toString('base64');

  it('returns 401 without Authorization header', async () => {
    const res = await request(app).get('/secret');
    expect(res.status).toBe(401);
  });

  it('returns 403 with wrong credentials', async () => {
    const res = await request(app).get('/secret').set('Authorization', wrongAuth);
    expect(res.status).toBe(403);
  });

  it('returns 200 with secret message on valid credentials', async () => {
    const res = await request(app).get('/secret').set('Authorization', validAuth);
    expect(res.status).toBe(200);
    expect(res.body.secret).toBe('test-secret');
  });
});
