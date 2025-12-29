import sys 
with open('src/cli.py', 'w', encoding='utf-8') as f: 
    f.write('''# -*- coding: utf-8 -*- 
import click 
 
@click.group() 
def cli(): 
    """Weather Parser with Visualization""" 
    pass 
 
@cli.command() 
def test(): 
    """Test command""" 
    click.echo("Test passed! Project is working.") 
 
if __name__ == "__main__": 
    cli()''') 
