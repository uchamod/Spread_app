document.addEventListener('DOMContentLoaded', () => {
    const copyButtons = document.querySelectorAll('.copy-button');

    copyButtons.forEach(button => {
        button.addEventListener('click', () => {
            const pre = button.previousElementSibling;
            const code = pre.querySelector('code');
            const textToCopy = code.innerText;

            navigator.clipboard.writeText(textToCopy).then(() => {
                const originalIcon = button.innerHTML;
                button.innerHTML = '<i class="fa-solid fa-check"></i>';
                button.classList.add('copied');
                
                setTimeout(() => {
                    button.innerHTML = originalIcon;
                    button.classList.remove('copied');
                }, 2000);
            }).catch(err => {
                console.error('Failed to copy text: ', err);
            });
        });
    });
});
