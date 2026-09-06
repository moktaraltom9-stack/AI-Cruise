const readline = require("readline");
const { plan } = require("../agent");
const { confirmAction } = require("../confirmation");
const { executeAction } = require("../executor");

function ask(question) {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  return new Promise(resolve => {
    rl.question(question, answer => {
      rl.close();
      resolve(answer.trim().toLowerCase());
    });
  });
}

async function showApp() {
  console.log("=== AI Cruise ===");
  console.log("اكتب transfer لاختبار عملية حساسة.");

  const action = await ask("الإجراء: ");

  console.log(plan("تنفيذ الإجراء", action));

  if (["transfer", "payment", "delete", "send"].includes(action)) {
    const answer = await ask("هل تؤكد؟ نعم/لا: ");
    const confirmed = ["نعم", "ن", "yes", "y"].includes(answer);

    const confirmation = confirmAction(action, confirmed);
    console.log(confirmation.message);

    if (confirmation.status !== "approved") {
      console.log("❌ لم يتم تنفيذ الإجراء.");
      return;
    }
  }

  console.log(executeAction(action, true).message);
}

module.exports = { showApp };
