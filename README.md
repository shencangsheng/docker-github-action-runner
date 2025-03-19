# Docker Github Action Runner

[![Docker Pulls](https://img.shields.io/docker/pulls/shencangsheng/pgrx.svg)](https://hub.docker.com/r/shencangsheng/action-runner)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE.md)

## 💡 Trying

```bash
cp docker-compose.example.yaml docker-compose.yaml
docker volume create action-runner-artifacts
vim docker-compose.yaml
docker compose up -d
```

<span style="color:gray"> Host your own runners and customize the environment used to run jobs in your GitHub Actions workflows. </span> [Learn more about self-hosted runners](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/about-self-hosted-runners).

| Parameter      | Description                |
| -------------- | -------------------------- |
| `REPO_URL`     | The URL of the repository. |
| `RUNNER_TOKEN` | The token for the runner.  |
| `RUNNER_NAME`  | The name of the runner.    |

## 📝 License

A short snippet describing the license (MIT)

MIT © Cangsheng Shen
