import {Octokit} from '@octokit/core';
import {paginateRest} from '@octokit/plugin-paginate-rest';

const MyOctokit = Octokit.plugin(paginateRest);

const octokit = new MyOctokit({
  auth: process.env.GITHUB_TOKEN,
});

const result = await octokit.paginate('GET /repos/{owner}/{repo}/actions/workflows/{workflow_id}/runs', {
  owner: process.argv[2],
  repo: process.argv[3],
  workflow_id: process.argv[4],
  per_page: 100,
});

const grouped = {};

for (const run of result) {
  let login = run.actor.login;
  grouped[login] ||= {attempts: 0, runs: 0};
  grouped[login].attempts += run.run_attempt > 1 ? 1 : 0;
  grouped[login].runs++;
}

console.log(grouped);
