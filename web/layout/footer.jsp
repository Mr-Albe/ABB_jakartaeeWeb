
<script>
    
    // Close sidebar when clicking the close button
    document.getElementById('toggleSidebar').addEventListener('click', function () {
        document.querySelector('.sidebar').classList.toggle('show');
    });

    // Toggle sidebar collapse on desktop
    document.getElementById('toggleSidebar').addEventListener('click', function () {
        document.querySelector('.sidebar').classList.toggle('collapsed');
    });

    // Responsive adjustments
    function handleResize() {
        if (window.innerWidth < 768) {
            document.querySelector('.sidebar').classList.remove('collapsed');
        }
    }

    // Dropdown functionality
    document.querySelectorAll('.dropdown-btn').forEach(button => {
        button.addEventListener('click', () => {
            const dropdownContainer = button.nextElementSibling;
            button.classList.toggle('open');
            dropdownContainer.classList.toggle('open');
        });
    });

    window.addEventListener('resize', handleResize);
    handleResize();
</script>
</body>
</html>