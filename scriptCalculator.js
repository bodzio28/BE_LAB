
document.addEventListener('DOMContentLoaded', () => {

    const display = document.getElementById('display');
    const buttons = document.querySelectorAll('.btn');

    
    let currentOperand = '';    
    let previousOperand = '';   
    let operation = null;      
    let shouldResetDisplay = false; 

    
    const updateDisplay = () => {
        display.innerText = currentOperand || previousOperand || '0';
    };


    const appendNumber = (number) => {
        
        if (shouldResetDisplay) {
            currentOperand = '';
            shouldResetDisplay = false;
        }
        
        if (currentOperand === '0' && number === '0') return;
        if (currentOperand === '0' && number !== '0') currentOperand = '';

        currentOperand += number;
    };

    
    const appendDecimal = () => {
        
        if (shouldResetDisplay) {
            currentOperand = '0.';
            shouldResetDisplay = false;
            return;
        }
        
        if (!currentOperand.includes('.')) {
            currentOperand = currentOperand === '' ? '0.' : currentOperand + '.';
        }
    };

    
    const chooseOperation = (op) => {
        
        if (currentOperand === '') return;
        
        if (previousOperand !== '') {
            compute();
        }
        operation = op;
        previousOperand = currentOperand;
        currentOperand = '';
    };

    
    const toggleSign = () => {
        if (currentOperand === '' || currentOperand === '0') return;
        currentOperand = (parseFloat(currentOperand) * -1).toString();
    };

    
    const compute = () => {
        let result;
        const prev = parseFloat(previousOperand);
        const current = parseFloat(currentOperand);

        
        if (isNaN(prev) || isNaN(current)) return;

        
        switch (operation) {
            case '+':
                result = prev + current;
                break;
            case '-':
                result = prev - current;
                break;
            case '*':
                result = prev * current;
                break;
            case '/':
                if (current === 0) {
                    alert("Błąd: Nie można dzielić przez zero!");
                    clearAll();
                    return;
                }
                result = prev / current;
                break;
            default:
                return;
        }

        currentOperand = result.toString();
        operation = null;
        previousOperand = '';
        shouldResetDisplay = true; 
    };

    
    const clearAll = () => {
        currentOperand = '';
        previousOperand = '';
        operation = null;
        shouldResetDisplay = false;
        updateDisplay(); 
    };

    
    buttons.forEach(button => {
        button.addEventListener('click', () => {
            const { value } = button.dataset; 
            const { id } = button; 
            if (value >= '0' && value <= '9') {
                appendNumber(value);
            } else if (value === '.') {
                appendDecimal();
            } else if (button.classList.contains('operation')) {
                chooseOperation(value);
            } else if (value === '+/-') {
                toggleSign();
            } else if (id === 'equals') {
                compute();
            } else if (id === 'clear') {
                clearAll();
            }
            updateDisplay();
        });
    });
    clearAll();
});