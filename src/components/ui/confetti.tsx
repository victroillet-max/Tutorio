"use client";

import { useEffect, useRef, useCallback } from "react";

interface ConfettiProps {
  trigger: boolean;
  duration?: number;
  particleCount?: number;
  onComplete?: () => void;
}

interface Particle {
  x: number;
  y: number;
  vx: number;
  vy: number;
  color: string;
  rotation: number;
  rotationSpeed: number;
  size: number;
  opacity: number;
}

const COLORS = [
  "#8B5CF6", // violet
  "#6366F1", // indigo
  "#EC4899", // pink
  "#F59E0B", // amber
  "#10B981", // emerald
  "#3B82F6", // blue
  "#EF4444", // red
  "#F97316", // orange
];

export function Confetti({ 
  trigger, 
  duration = 3000, 
  particleCount = 100,
  onComplete 
}: ConfettiProps) {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const animationRef = useRef<number | undefined>(undefined);
  const particlesRef = useRef<Particle[]>([]);

  const createParticles = useCallback(() => {
    const particles: Particle[] = [];
    const canvas = canvasRef.current;
    if (!canvas) return particles;

    for (let i = 0; i < particleCount; i++) {
      particles.push({
        x: canvas.width / 2 + (Math.random() - 0.5) * 200,
        y: canvas.height / 2,
        vx: (Math.random() - 0.5) * 15,
        vy: Math.random() * -15 - 5,
        color: COLORS[Math.floor(Math.random() * COLORS.length)],
        rotation: Math.random() * 360,
        rotationSpeed: (Math.random() - 0.5) * 10,
        size: Math.random() * 10 + 5,
        opacity: 1,
      });
    }
    return particles;
  }, [particleCount]);

  const animate = useCallback(() => {
    const canvas = canvasRef.current;
    const ctx = canvas?.getContext("2d");
    if (!canvas || !ctx) return;

    ctx.clearRect(0, 0, canvas.width, canvas.height);

    const gravity = 0.3;
    const friction = 0.99;
    let activeParticles = 0;

    particlesRef.current.forEach((particle) => {
      if (particle.opacity <= 0) return;

      // Physics
      particle.vy += gravity;
      particle.vx *= friction;
      particle.x += particle.vx;
      particle.y += particle.vy;
      particle.rotation += particle.rotationSpeed;
      
      // Fade out when below viewport
      if (particle.y > canvas.height - 50) {
        particle.opacity -= 0.02;
      }

      // Draw particle
      ctx.save();
      ctx.translate(particle.x, particle.y);
      ctx.rotate((particle.rotation * Math.PI) / 180);
      ctx.globalAlpha = particle.opacity;
      ctx.fillStyle = particle.color;
      
      // Draw a rectangle (confetti piece)
      ctx.fillRect(
        -particle.size / 2,
        -particle.size / 4,
        particle.size,
        particle.size / 2
      );
      
      ctx.restore();

      if (particle.opacity > 0) {
        activeParticles++;
      }
    });

    if (activeParticles > 0) {
      animationRef.current = requestAnimationFrame(animate);
    } else {
      onComplete?.();
    }
  }, [onComplete]);

  useEffect(() => {
    if (!trigger) return;

    const canvas = canvasRef.current;
    if (!canvas) return;

    // Set canvas size
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;

    // Create particles
    particlesRef.current = createParticles();

    // Start animation
    animationRef.current = requestAnimationFrame(animate);

    // Cleanup timeout
    const timeout = setTimeout(() => {
      if (animationRef.current) {
        cancelAnimationFrame(animationRef.current);
      }
      onComplete?.();
    }, duration);

    return () => {
      if (animationRef.current) {
        cancelAnimationFrame(animationRef.current);
      }
      clearTimeout(timeout);
    };
  }, [trigger, duration, createParticles, animate, onComplete]);

  if (!trigger) return null;

  return (
    <canvas
      ref={canvasRef}
      className="fixed inset-0 pointer-events-none z-[9999]"
      aria-hidden="true"
    />
  );
}

// Hook for easy confetti triggering
export function useConfetti() {
  const [showConfetti, setShowConfetti] = useState(false);

  const triggerConfetti = useCallback(() => {
    setShowConfetti(true);
  }, []);

  const handleComplete = useCallback(() => {
    setShowConfetti(false);
  }, []);

  return {
    showConfetti,
    triggerConfetti,
    handleComplete,
    ConfettiComponent: () => (
      <Confetti trigger={showConfetti} onComplete={handleComplete} />
    ),
  };
}

// Need to import useState for the hook
import { useState } from "react";

